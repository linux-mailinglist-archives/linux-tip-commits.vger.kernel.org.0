Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09AE292C2A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgJSRDP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 13:03:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgJSRCt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 13:02:49 -0400
Date:   Mon, 19 Oct 2020 17:02:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603126967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lnaDqZ2C9vZg4IyjhJIanNaJnZPz/KL0/LzWNstmiQg=;
        b=JIhM7pWc2I2t3Yu3uXACm5+xFxf1JjgOxS0m90KULbR7nBvHB1iZftVoeQYuu+TEKL0tYl
        ZcxtppyXDv5kzVUwJ6XGcjEBavc9l9Ae+hhR4aaPkbK+9umCsCBVD5pXmo+PYZwG7vBMIZ
        nmbHvJlgobw5YIslDz6ocEtDYM4mnWZI+4Bj21YZTWYtv25Pz/87+Sz/D+uzaKJ37Hnyoc
        eYd7r7gE4rWuTOaWsuuNNzyAOACK2GOu+5vbyYJBVSFFDYTe86ByojJxgvMIIhQtFcnvIe
        Ck+8raYIPRaVTAUIdkPawXUZlFpI8ukgRvql4Ku2EDYrTej23v+DLjTNYsBNBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603126967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lnaDqZ2C9vZg4IyjhJIanNaJnZPz/KL0/LzWNstmiQg=;
        b=iMZp05oB2QyEFtQXCzofPcL7TzXHZOU26CXvt6l+RDOIExIr68pY6sG8pNfoVu1VJwRm3/
        JtULXjB+ZSHtQkDQ==
From:   "tip-bot2 for Luiz Augusto von Dentz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] Bluetooth: L2CAP: Fix calling sk_filter on
 non-socket based channel
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160312696694.7002.9566105764222211231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3dede8ebf46338473143a1e792cc2cacc244f1f2
Gitweb:        https://git.kernel.org/tip/3dede8ebf46338473143a1e792cc2cacc244f1f2
Author:        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
AuthorDate:    Thu, 06 Aug 2020 11:17:12 -07:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Sat, 17 Oct 2020 08:31:21 +02:00

Bluetooth: L2CAP: Fix calling sk_filter on non-socket based channel

commit f19425641cb2572a33cb074d5e30283720bd4d22 upstream.

Only sockets will have the chan->data set to an actual sk, channels
like A2MP would have its own data which would likely cause a crash when
calling sk_filter, in order to fix this a new callback has been
introduced so channels can implement their own filtering if necessary.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/bluetooth/l2cap.h |  2 ++
 net/bluetooth/l2cap_core.c    |  7 ++++---
 net/bluetooth/l2cap_sock.c    | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 8f1e6a7..1d12329 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -665,6 +665,8 @@ struct l2cap_ops {
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long hdr_len,
 					       unsigned long len, int nb);
+	int			(*filter) (struct l2cap_chan * chan,
+					   struct sk_buff *skb);
 };
 
 struct l2cap_conn {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ade83e2..1ab27b9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7301,9 +7301,10 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if ((chan->mode == L2CAP_MODE_ERTM ||
-	     chan->mode == L2CAP_MODE_STREAMING) && sk_filter(chan->data, skb))
-		goto drop;
+	if (chan->ops->filter) {
+		if (chan->ops->filter(chan, skb))
+			goto drop;
+	}
 
 	if (!control->sframe) {
 		int err;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e1a3e66..79b4c01 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1663,6 +1663,19 @@ static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
 	sk->sk_state_change(sk);
 }
 
+static int l2cap_sock_filter(struct l2cap_chan *chan, struct sk_buff *skb)
+{
+	struct sock *sk = chan->data;
+
+	switch (chan->mode) {
+	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
+		return sk_filter(sk, skb);
+	}
+
+	return 0;
+}
+
 static const struct l2cap_ops l2cap_chan_ops = {
 	.name			= "L2CAP Socket Interface",
 	.new_connection		= l2cap_sock_new_connection_cb,
@@ -1678,6 +1691,7 @@ static const struct l2cap_ops l2cap_chan_ops = {
 	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
 	.get_peer_pid		= l2cap_sock_get_peer_pid_cb,
 	.alloc_skb		= l2cap_sock_alloc_skb_cb,
+	.filter			= l2cap_sock_filter,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
