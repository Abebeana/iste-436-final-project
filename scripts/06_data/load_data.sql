-- NOTE:
-- Invalid records (data errors, wrong format, etc.) are written to the .bad file.
-- Discarded records (valid data that do not meet filtering conditions) are written to the .dsc file.

sqlldr control=sqlldr/LoadCUSTOMER.ctl log=LoadCUSTOMER.log bad=LoadCUSTOMER.bad discard=LoadCUSTOMER.dsc
sqlldr control=sqlldr/LoadRESTAURANT.ctl log=LoadRESTAURANT.log bad=LoadRESTAURANT.bad discard=LoadRESTAURANT.dsc
sqlldr control=sqlldr/LoadMENU_ITEM.ctl log=LoadMENU_ITEM.log bad=LoadMENU_ITEM.bad discard=LoadMENU_ITEM.dsc
sqlldr control=sqlldr/LoadORDERS.ctl log=LoadORDERS.log bad=LoadORDERS.bad discard=LoadORDERS.dsc
sqlldr control=sqlldr/LoadORDER_ITEM.ctl log=LoadORDER_ITEM.log bad=LoadORDER_ITEM.bad discard=LoadORDER_ITEM.dsc
sqlldr control=sqlldr/LoadDRIVER.ctl log=LoadDRIVER.log bad=LoadDRIVER.bad discard=LoadDRIVER.dsc
sqlldr control=sqlldr/LoadDELIVERY.ctl log=LoadDELIVERY.log bad=LoadDELIVERY.bad discard=LoadDELIVERY.dsc
sqlldr control=sqlldr/LoadPAYMENT.ctl log=LoadPAYMENT.log bad=LoadPAYMENT.bad discard=LoadPAYMENT.dsc
sqlldr control=sqlldr/LoadREVIEW.ctl log=LoadREVIEW.log bad=LoadREVIEW.bad discard=LoadREVIEW.dsc
sqlldr control=sqlldr/LoadORDER_STATUS_LOG.ctl log=LoadORDER_STATUS_LOG.log bad=LoadORDER_STATUS_LOG.bad discard=LoadORDER_STATUS_LOG.dsc
