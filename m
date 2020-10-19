Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92B292C32
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 19:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbgJSRDP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 13:03:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32860 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730947AbgJSRCs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 13:02:48 -0400
Date:   Mon, 19 Oct 2020 17:02:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603126967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I4prWtepFhy3bxtt4MIIMMRn0PYif2sTXQiyd4JFXNw=;
        b=uWecLYAm/pNiCbLKzYYWdHStjDGMGzeuXowkxfPP3+7mT4kC1FQE/NvdZthTuIrRAMKNcw
        +YpuzZG++S0g6RxuKhu1CZObRAvGFtgRwP9A7RuxXPR8HXs0k255d+Q07fhjYsz+d6T3Zd
        +F/fAccfZkJnMJRLhuf7rDAJH3H9ZpQf7ay6bz3E5fcxINpcehzwap/RUHjfykXLryWECg
        aGxtYNbNpSVMS5Jn91pREHUNg+rcDeCt/8AsSbT455Xs4BBn6tpTlz9b5b+OtMqKNiIJGh
        qTVwQ+nbU7JiuSfZ++dodImu7ZmP9ARikgsCIcTnjNt3KKOR3NhlUqrtsHejRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603126967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I4prWtepFhy3bxtt4MIIMMRn0PYif2sTXQiyd4JFXNw=;
        b=s0R7syjb4LvA5GpNkANc2RMnECVu0aSziF1AMS1DtFKiY5O7t8exPOhcNaGQzyxqbxK274
        6A8IOkhFebjp4mDA==
From:   "tip-bot2 for Luiz Augusto von Dentz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] Bluetooth: MGMT: Fix not checking if BT_HS is enabled
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160312696638.7002.14202653033190309216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a0a91211dd0ac6f24393a2917a258de5aeedb842
Gitweb:        https://git.kernel.org/tip/a0a91211dd0ac6f24393a2917a258de5aeedb842
Author:        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
AuthorDate:    Thu, 06 Aug 2020 11:17:14 -07:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Sat, 17 Oct 2020 08:31:21 +02:00

Bluetooth: MGMT: Fix not checking if BT_HS is enabled

commit b560a208cda0297fef6ff85bbfd58a8f0a52a543 upstream.

This checks if BT_HS is enabled relecting it on MGMT_SETTING_HS instead
of always reporting it as supported.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/mgmt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5bbe710..5758ccb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -782,7 +782,8 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 
 		if (lmp_ssp_capable(hdev)) {
 			settings |= MGMT_SETTING_SSP;
-			settings |= MGMT_SETTING_HS;
+			if (IS_ENABLED(CONFIG_BT_HS))
+				settings |= MGMT_SETTING_HS;
 		}
 
 		if (lmp_sc_capable(hdev))
@@ -1815,6 +1816,10 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
+	if (!IS_ENABLED(CONFIG_BT_HS))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	status = mgmt_bredr_support(hdev);
 	if (status)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS, status);
