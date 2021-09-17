Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9175840F8F1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 15:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhIQNSm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhIQNSm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 09:18:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BF0C061574;
        Fri, 17 Sep 2021 06:17:20 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631884639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVT6FtipNzvGbKA/mqO+GFWba2iEJpsvKM+7syl6gBA=;
        b=OxIgzo91UOPyxHkjoouOrpTfvVn3msv1STLNPr6PMoClXqZZnznNHg8xKnWbtxnD5oHMkf
        36RMUULN1mquHkMWkOIAqiJ1E7B5MvswyLAcP09U36Dn6HPyP+Gzt9sXuV74y7K58ZLMm3
        ahckED0crnoqM4IwIe2LOOKUCh/ZXs4ox/4tS5rsNl9RRAqbLiuIbdv+nU/Cu1T1kMnVBf
        W/f95tDhtEDyZuGgLr2vUIBdOztez25EaeIpuQ5XAiIy/sn7qJtxIVGuKy4ANtkoXE92Sb
        IDu+KEVRfyXhTcPKZ1ctv+WWqZREu9FJ48jup/xYN+lyQlWyw7B0/XFKh9YeYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631884639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVT6FtipNzvGbKA/mqO+GFWba2iEJpsvKM+7syl6gBA=;
        b=Bp9XHIQqABGoq5r/I8yeLDdbkuPu70Z31Ztw7bub/+1wIv4k5mZ5amGri73RpFy4lfgRCr
        1/l7V6pVCQ/pnmAw==
From:   "tip-bot2 for Shaokun Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Cleanup the repeated declaration
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1629875224-32751-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1629875224-32751-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <163188463814.25758.7085162105849668349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f7427ba5ce9c5438ad392b6cbcc4ca8a0487d7e7
Gitweb:        https://git.kernel.org/tip/f7427ba5ce9c5438ad392b6cbcc4ca8a0487d7e7
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Wed, 25 Aug 2021 15:07:04 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 15:08:45 +02:00

locking/lockdep: Cleanup the repeated declaration

'struct task_struct' has been decleared twice, so keep the top one and
cleanup the repeated one.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1629875224-32751-1-git-send-email-zhangshaokun@hisilicon.com
---
 include/linux/debug_locks.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 3f49e65..dbb409d 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -47,8 +47,6 @@ extern int debug_locks_off(void);
 # define locking_selftest()	do { } while (0)
 #endif
 
-struct task_struct;
-
 #ifdef CONFIG_LOCKDEP
 extern void debug_show_all_locks(void);
 extern void debug_show_held_locks(struct task_struct *task);
