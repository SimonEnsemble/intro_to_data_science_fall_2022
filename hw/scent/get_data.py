import pyrfume
import pandas as pd


data_sets = ["leffingwell", "goodscents"]
csvs = ["molecules", "behavior_sparse", "identifiers"]
for ds in data_sets:
    molecules = pyrfume.load_data(ds + '/molecules.csv')
    behavior = pyrfume.load_data(ds + '/behavior_sparse.csv')
    if ds == "goodscents":
        identifiers = pyrfume.load_data(ds + '/identifiers.csv')

    pyrfume.set_data_path(ds)
    pyrfume.save_data(molecules, 'molecules.csv')
    pyrfume.save_data(behavior, 'behavior.csv')
    if ds == "goodscents":
        pyrfume.save_data(identifiers, 'identifiers.csv')
