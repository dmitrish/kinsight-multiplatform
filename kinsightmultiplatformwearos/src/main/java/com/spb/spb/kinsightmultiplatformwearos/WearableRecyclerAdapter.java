package com.spb.spb.kinsightmultiplatformwearos;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.wear.widget.WearableRecyclerView;

import com.kinsight.kinsightmultiplatform.IdeaModelLogicDecorator;
import com.kinsight.kinsightmultiplatform.models.IdeaModel;

import org.w3c.dom.Text;

import java.util.List;

public class WearableRecyclerAdapter extends WearableRecyclerView.Adapter<WearableRecyclerAdapter.ViewHolder> {

    private List<IdeaModel> mData;
    private LayoutInflater mInflater;
    private ItemClickListener mClickListener;

    // data is passed into the constructor
    WearableRecyclerAdapter(Context context, List<IdeaModel> data) {
        this.mInflater = LayoutInflater.from(context);
        this.mData = data;
    }

    // inflates the row layout from xml when needed
    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.idea_item, parent, false);
        return new ViewHolder(view);
    }

    // binds the data to the TextView in each row
    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {

        IdeaModel itemIdea = mData.get(position);
        IdeaModelLogicDecorator decorator = new IdeaModelLogicDecorator(itemIdea);
        holder.myTextView.setText(itemIdea.getSecurityName());
        holder.securityTicker.setText(itemIdea.getSecurityTicker());
        holder.createdBy.setText(itemIdea.getCreatedBy());
        holder.ideaAlpha.setText(decorator.getDisplayValueForAlpha());
        holder.ideaPsi.setText( "φ   02.35");
        holder.alphaImage.setImageResource(getFishImageForAlpha(itemIdea.getAlpha()));
      //  String animal = mData.get(position);
       // holder.myTextView.setText(animal);
    }

    private Integer getFishImageForAlpha(Double alpha) {
        if (alpha >= 4.0) {
            return R.drawable.ic_fish_green;
        }
        else if (alpha >= 3.0) {
            return R.drawable.ic_fish_yellow;
        }
        else if (alpha >= 1.0) {
            return R.drawable.ic_fish_pale_yellow;
        }
        else{
            return R.drawable.ic_fish_superhot;
        }

    }

    // total number of rows
    @Override
    public int getItemCount() {
        return mData.size();
    }


    // stores and recycles views as they are scrolled off screen
    public class ViewHolder extends WearableRecyclerView.ViewHolder implements View.OnClickListener {
        TextView myTextView;
        TextView securityTicker;
        TextView createdBy;
        TextView ideaAlpha;
        TextView ideaPsi;
        ImageView alphaImage;

        ViewHolder(View itemView) {
            super(itemView);
            myTextView = itemView.findViewById(R.id.nameText);
            securityTicker = itemView.findViewById(R.id.ideaSecurityName);
            createdBy = itemView.findViewById(R.id.ideaCreatedBy);
            ideaAlpha = itemView.findViewById(R.id.ideaAlpha);
            ideaPsi =itemView.findViewById(R.id.ideaPsi);
            alphaImage = itemView.findViewById(R.id.ideaImage2);
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View view) {
            if (mClickListener != null) mClickListener.onItemClick(view, getAdapterPosition());
        }


    }

    // convenience method for getting data at click position
    IdeaModel getItem(int id) {
        return mData.get(id);
    }

    // allows clicks events to be caught
    void setClickListener(ItemClickListener itemClickListener) {
        this.mClickListener = itemClickListener;
    }

    // parent activity will implement this method to respond to click events
    public interface ItemClickListener {
        void onItemClick(View view, int position);
    }
}