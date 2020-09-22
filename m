Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903C027486D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Sep 2020 20:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIVSmu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Sep 2020 14:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVSms (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Sep 2020 14:42:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F591C061755;
        Tue, 22 Sep 2020 11:42:48 -0700 (PDT)
Date:   Tue, 22 Sep 2020 18:42:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600800166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDF3LmYYtba4CPbwBlFtLzTEVFwUNBc19iFUGF/xMsM=;
        b=ci4zngPDGHqk6K9cwxO2IwnW7rU8ePa1DJ1eOO6lUbdIWtNSbvnMA6+A4rWjgm5iujdRjW
        kkuZTVu9tXY4jASkT70YsoQ4qI5cImckAOvx0Tab3bT/Ac6JukdYnl8pCm6MqVQIpDZltP
        0V28pm4qz5ckK2hxwFmUTXGpj4diMhUp/bIaCg8HGv0cOEQRpI16ofT5Tey7E8uAdgnccy
        /qHXg2FsnlfvYdr/UE+rty4q3ta1CyZc2YJuHc0Tj/3fMjsc74dhUvTt3ZuLo+KrB14dR2
        /Xfo5UDuURM5iD9+QBqcenzm4Q8d3gWWUy5ZwV2glbcVSDU6qfyuGe/HGB8OIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600800166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDF3LmYYtba4CPbwBlFtLzTEVFwUNBc19iFUGF/xMsM=;
        b=YB9FgR4nkycWooqiBSuJDwn2dY1jdBA7HJs4bDiTT3ME4ClAj0fow4igIBy37f6gujg4D4
        blqnCqQhD8hmHoDg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/entry: Fix typo in comments for
 syscall_enter_from_user_mode()
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200919080936.259819-1-keescook@chromium.org>
References: <20200919080936.259819-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <160080016557.6608.15555894134715499563.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     900ffe39fec908e0aa26a30612e43ebc7140db79
Gitweb:        https://git.kernel.org/tip/900ffe39fec908e0aa26a30612e43ebc7140db79
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Sat, 19 Sep 2020 01:09:36 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Sep 2020 18:24:46 +02:00

x86/entry: Fix typo in comments for syscall_enter_from_user_mode()

Just to help myself and others with finding the correct function names,
fix a typo for "usermode" vs "user_mode".

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200919080936.259819-1-keescook@chromium.org
---
 include/linux/entry-common.h | 2 +-
 kernel/entry/common.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index efebbff..3b6754d 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -38,7 +38,7 @@
 #endif
 
 /*
- * TIF flags handled in syscall_enter_from_usermode()
+ * TIF flags handled in syscall_enter_from_user_mode()
  */
 #ifndef ARCH_SYSCALL_ENTER_WORK
 # define ARCH_SYSCALL_ENTER_WORK	(0)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index fcae019..7c7b9d0 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -183,7 +183,7 @@ static inline bool report_single_step(unsigned long ti_work)
 /*
  * If TIF_SYSCALL_EMU is set, then the only reason to report is when
  * TIF_SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_usermode().
+ * instruction has been already reported in syscall_enter_from_user_mode().
  */
 #define SYSEMU_STEP	(_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)
 
