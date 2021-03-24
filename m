Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE834726B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhCXHWq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38648 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhCXHW3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:29 -0400
Date:   Wed, 24 Mar 2021 07:22:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMTdHXbv8eVj96jtLmRysp8zykl9xBjwUpZgI9zBLjE=;
        b=esiMV3VMVfesA/HsXZy0LxTjUvIYiJwVxro0iP5H1KIrtMmQFSetCIdaz61XmIJqaTmEIn
        y7OBG7RvSKDEtX1YCAm7vgQ8xcbs6TP/gOEjgbo0YzTfLwwiBrrJEg0SDof0bgI3RpB040
        hIBI9e1E5LHds0u0y2GJ5MqYpklbV9q8UCryeotuFR1DAJ4waSrSRXSIqFbQx6PqAAj9Lt
        kEca1d7BVUF1p1iwyHxEJp+EzAUKEc7JgkAJlP4Mc/jNfBL0DcjMTLANOHOqH4TSxwZF5z
        Rm0oHYBeuhcnjLxfa9cYJKi9veyG3iWMN3IDdABUKKAd5aQz3/3Kgl+F64UfqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMTdHXbv8eVj96jtLmRysp8zykl9xBjwUpZgI9zBLjE=;
        b=tDYQ6iYtENo9yaFahCEJXnWXA2mO/MY1kB4yJsOdzebv2xahzZlvka4AGbSj+wT6pDszsB
        wU51e6FnCktDQfDQ==
From:   "tip-bot2 for Shaokun Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Remove repeated declaration
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1616564440-61318-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1616564440-61318-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <161657054669.398.3424034889120871152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5965a7adbd72dd9b288c0911cb73719fed1efa08
Gitweb:        https://git.kernel.org/tip/5965a7adbd72dd9b288c0911cb73719fed1efa08
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Wed, 24 Mar 2021 13:40:40 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:15:19 +01:00

locking/mutex: Remove repeated declaration

Commit 0cd39f4600ed ("locking/seqlock, headers: Untangle the spaghetti monster")
introduces 'struct ww_acquire_ctx' again, remove the repeated declaration and move
the pre-declarations to the top.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/1616564440-61318-1-git-send-email-zhangshaokun@hisilicon.com
---
 include/linux/mutex.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 0cd631a..e7a1267 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,6 +20,7 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
+struct ww_class;
 struct ww_acquire_ctx;
 
 /*
@@ -65,9 +66,6 @@ struct mutex {
 #endif
 };
 
-struct ww_class;
-struct ww_acquire_ctx;
-
 struct ww_mutex {
 	struct mutex base;
 	struct ww_acquire_ctx *ctx;
