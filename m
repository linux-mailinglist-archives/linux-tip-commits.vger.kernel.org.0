Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B66292C28
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgJSRDL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 13:03:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32896 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbgJSRCu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 13:02:50 -0400
Date:   Mon, 19 Oct 2020 17:02:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603126968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Tm1GU0z2kLwJo+ERLYEBrrFdphlrSNg7336nNL5JMMQ=;
        b=PkhegT7o8t7rA8Yu5uPda9aLjfMz1VD4lbOzo1jK+mxp4T/YQgR0zYhZiApuMLF/tNsWxf
        oqXsDptjtFH3etzIkhi9Q77gVMrKIOTjpRynOeC3MWmMscqIMYeWCqNIITV1uTrAThd6Nz
        ZRfMy1v6xuL05sZ9GCdSihuNSNTR+meB2JitdfmVGIASJgmk/2sqSoO9gjS+aK6FNQWUh8
        k6rsHKHWmCDRuHlSWa52UXT++DgHT/27ikkpZFoQ91lAQbuxfmQuWDTi8roBKPJbbyUpA8
        1jMtvMKvS4Bii1214qYn2GzVb+UZLg8R3sadfb0BPwxU5v1MW/cA+A4VqtbYyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603126968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Tm1GU0z2kLwJo+ERLYEBrrFdphlrSNg7336nNL5JMMQ=;
        b=aYHaQ/Yu3hn5OTcQ9L6aUcgr9T6ujDvg70/tguOJiSOoyW4DioN+y0sJ3x1x/d3Dyyr+ax
        8+r66qYDxxX6ZCAw==
From:   "tip-bot2 for Luiz Augusto von Dentz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] Bluetooth: A2MP: Fix not initializing all members
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160312696749.7002.7019206176645784064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     122414e2d2cba74dc154263cabca9560ff8011ac
Gitweb:        https://git.kernel.org/tip/122414e2d2cba74dc154263cabca9560ff8011ac
Author:        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
AuthorDate:    Thu, 06 Aug 2020 11:17:11 -07:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Sat, 17 Oct 2020 08:31:20 +02:00

Bluetooth: A2MP: Fix not initializing all members

commit eddb7732119d53400f48a02536a84c509692faa8 upstream.

This fixes various places where a stack variable is used uninitialized.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/a2mp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 26526be..da7fd7c 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -226,6 +226,9 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 			struct a2mp_info_req req;
 
 			found = true;
+
+			memset(&req, 0, sizeof(req));
+
 			req.id = cl->id;
 			a2mp_send(mgr, A2MP_GETINFO_REQ, __next_ident(mgr),
 				  sizeof(req), &req);
@@ -305,6 +308,8 @@ static int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	if (!hdev || hdev->dev_type != HCI_AMP) {
 		struct a2mp_info_rsp rsp;
 
+		memset(&rsp, 0, sizeof(rsp));
+
 		rsp.id = req->id;
 		rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
 
@@ -348,6 +353,8 @@ static int a2mp_getinfo_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 	if (!ctrl)
 		return -ENOMEM;
 
+	memset(&req, 0, sizeof(req));
+
 	req.id = rsp->id;
 	a2mp_send(mgr, A2MP_GETAMPASSOC_REQ, __next_ident(mgr), sizeof(req),
 		  &req);
@@ -376,6 +383,8 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		struct a2mp_amp_assoc_rsp rsp;
 		rsp.id = req->id;
 
+		memset(&rsp, 0, sizeof(rsp));
+
 		if (tmp) {
 			rsp.status = A2MP_STATUS_COLLISION_OCCURED;
 			amp_mgr_put(tmp);
@@ -464,7 +473,6 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 				   struct a2mp_cmd *hdr)
 {
 	struct a2mp_physlink_req *req = (void *) skb->data;
-
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
 	struct hci_conn *hcon;
@@ -475,6 +483,8 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	BT_DBG("local_id %d, remote_id %d", req->local_id, req->remote_id);
 
+	memset(&rsp, 0, sizeof(rsp));
+
 	rsp.local_id = req->remote_id;
 	rsp.remote_id = req->local_id;
 
@@ -553,6 +563,8 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	BT_DBG("local_id %d remote_id %d", req->local_id, req->remote_id);
 
+	memset(&rsp, 0, sizeof(rsp));
+
 	rsp.local_id = req->remote_id;
 	rsp.remote_id = req->local_id;
 	rsp.status = A2MP_STATUS_SUCCESS;
@@ -675,6 +687,8 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (err) {
 		struct a2mp_cmd_rej rej;
 
+		memset(&rej, 0, sizeof(rej));
+
 		rej.reason = cpu_to_le16(0);
 		hdr = (void *) skb->data;
 
@@ -898,6 +912,8 @@ void a2mp_send_getinfo_rsp(struct hci_dev *hdev)
 
 	BT_DBG("%s mgr %p", hdev->name, mgr);
 
+	memset(&rsp, 0, sizeof(rsp));
+
 	rsp.id = hdev->id;
 	rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
 
@@ -995,6 +1011,8 @@ void a2mp_send_create_phy_link_rsp(struct hci_dev *hdev, u8 status)
 	if (!mgr)
 		return;
 
+	memset(&rsp, 0, sizeof(rsp));
+
 	hs_hcon = hci_conn_hash_lookup_state(hdev, AMP_LINK, BT_CONNECT);
 	if (!hs_hcon) {
 		rsp.status = A2MP_STATUS_UNABLE_START_LINK_CREATION;
@@ -1027,6 +1045,8 @@ void a2mp_discover_amp(struct l2cap_chan *chan)
 
 	mgr->bredr_chan = chan;
 
+	memset(&req, 0, sizeof(req));
+
 	req.mtu = cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
 	req.ext_feat = 0;
 	a2mp_send(mgr, A2MP_DISCOVER_REQ, 1, sizeof(req), &req);
