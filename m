Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5E2340324
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 11:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCRK1P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 06:27:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCRK1E (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 06:27:04 -0400
Date:   Thu, 18 Mar 2021 10:27:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616063223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBPE5O8ROIqUidAehLuKNFiFUQu+vG9aqnGO5mvlSS4=;
        b=3DMTM3S8LTdicuH4w2MiAcS1M1Ov61lcf7OqEBKClxbaB6Pq7Jec7e8boAZ/pP3+Z8pD/C
        tRtE1RkxYtH3rsr6n18X9AqYqLreC3B8YvFYHiDWd5NqFJAMRDgQrsxhtA7lVwDB+iCkFE
        GRXZ+/v8s+ElJq0KXbm4W63NqapCJLnB6SuMzfvy0dsohMuHe0QPHoc3C3UUlzblKwnWBB
        9TO+AiO6RFrWvGs+lQTXis0LdhdiXQBLNSc9I5KT5BbDADmd3B9VzENi/1ObNrtVqETkTl
        WMe1vt43i04lGbWz78Sy9sp/7I9f3EP2Q1kL0qMQK7mvKaAl23j0ts/hRBX/DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616063223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBPE5O8ROIqUidAehLuKNFiFUQu+vG9aqnGO5mvlSS4=;
        b=HNzIpj640drkHtLRwqcx4iurEKZygMsEsM/JhwrskHX8XNSEknUQ46O9gm7CXIH0DBJwVN
        cdgl3GmWmz2bFQAg==
From:   "tip-bot2 for Greg Kroah-Hartman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/debug: Remove dentry pointer for debugfs
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210216155020.1012407-1-gregkh@linuxfoundation.org>
References: <20210216155020.1012407-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Message-ID: <161606322285.398.12181234874113182428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     44511ab344c755d1f216bf421e92fbc2777e87fe
Gitweb:        https://git.kernel.org/tip/44511ab344c755d1f216bf421e92fbc2777e87fe
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Tue, 16 Feb 2021 16:50:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Mar 2021 11:20:26 +01:00

time/debug: Remove dentry pointer for debugfs

There is no need to keep the dentry pointer around for the created
debugfs file, as it is only needed when removing it from the system.
When it is to be removed, ask debugfs itself for the pointer, to save on
storage and make things a bit simpler.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210216155020.1012407-1-gregkh@linuxfoundation.org

---
 kernel/time/test_udelay.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 77c6300..13b11eb 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -21,7 +21,6 @@
 #define DEBUGFS_FILENAME "udelay_test"
 
 static DEFINE_MUTEX(udelay_test_lock);
-static struct dentry *udelay_test_debugfs_file;
 static int udelay_test_usecs;
 static int udelay_test_iterations = DEFAULT_ITERATIONS;
 
@@ -138,8 +137,8 @@ static const struct file_operations udelay_test_debugfs_ops = {
 static int __init udelay_test_init(void)
 {
 	mutex_lock(&udelay_test_lock);
-	udelay_test_debugfs_file = debugfs_create_file(DEBUGFS_FILENAME,
-			S_IRUSR, NULL, NULL, &udelay_test_debugfs_ops);
+	debugfs_create_file(DEBUGFS_FILENAME, S_IRUSR, NULL, NULL,
+			    &udelay_test_debugfs_ops);
 	mutex_unlock(&udelay_test_lock);
 
 	return 0;
@@ -150,7 +149,7 @@ module_init(udelay_test_init);
 static void __exit udelay_test_exit(void)
 {
 	mutex_lock(&udelay_test_lock);
-	debugfs_remove(udelay_test_debugfs_file);
+	debugfs_remove(debugfs_lookup(DEBUGFS_FILENAME, NULL));
 	mutex_unlock(&udelay_test_lock);
 }
 
