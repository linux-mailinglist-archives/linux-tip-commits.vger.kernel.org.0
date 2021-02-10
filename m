Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7231688B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 15:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBJOAO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 09:00:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhBJOAI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 09:00:08 -0500
Date:   Wed, 10 Feb 2021 13:59:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKV+z6ZMuvcAFoI9OCCVr4XK0py+1qbUPJ3U9n8hSUE=;
        b=WCqEkNRL03iX2Sq1AdL4w6lxg5bIDEutjwOiogXtanPyUeNO/YrnR5X+0jGUjKY182ZPAn
        wuYsfNuSV1LFfzBH54EwmwLenx9m9Gy2L17VB8M8oLvC14gHytb6fE1uuCcHVn1+fEU1+M
        BR036hycO7F0Q9Lclg73hpCszlYrGM8ojMK841BBSybarBrIBBqpQla7UazwV+rJWoy+y2
        1+UVQ0pMK3QxHbSG7A4e33koNkeg/ynhWjuSrr/nE4rfrr+UmXv4b2zDUGNGgCKHWesH/e
        8LDZNEGO8rjP+hTtOpS3UVbSEyH/5664wuXZ0FFRWF6P0M8t93qulUIGpqE0oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965565;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKV+z6ZMuvcAFoI9OCCVr4XK0py+1qbUPJ3U9n8hSUE=;
        b=gDb/yBxdDqx+PV/uZd2kubgenNIYNIHREnKLrJsTfnOT7rSo1GjMy748mxTAe0t9xMsKte
        vqKxeVLzE7BbmEDQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] checkpatch: Don't check for mutex_trylock_recursive()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210085248.219210-3-bigeasy@linutronix.de>
References: <20210210085248.219210-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <161296556493.23325.15205619721544468262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6c80408a8a0360fa9223b8c21c0ab8ef42e88bfe
Gitweb:        https://git.kernel.org/tip/6c80408a8a0360fa9223b8c21c0ab8ef42e88bfe
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 09:52:48 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:40 +01:00

checkpatch: Don't check for mutex_trylock_recursive()

mutex_trylock_recursive() has been removed from the tree, there is no
need to check for it.

Remove traces of mutex_trylock_recursive()'s existence.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210210085248.219210-3-bigeasy@linutronix.de
---
 scripts/checkpatch.pl | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92e888e..15f7f4f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7069,12 +7069,6 @@ sub process {
 			}
 		}
 
-# check for mutex_trylock_recursive usage
-		if ($line =~ /mutex_trylock_recursive/) {
-			ERROR("LOCKING",
-			      "recursive locking is bad, do not use this ever.\n" . $herecurr);
-		}
-
 # check for lockdep_set_novalidate_class
 		if ($line =~ /^.\s*lockdep_set_novalidate_class\s*\(/ ||
 		    $line =~ /__lockdep_no_validate__\s*\)/ ) {
