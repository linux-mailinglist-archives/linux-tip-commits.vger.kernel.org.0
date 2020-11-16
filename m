Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68042B5389
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 22:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbgKPVLt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 16:11:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbgKPVLg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:36 -0500
Date:   Mon, 16 Nov 2020 21:11:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605561095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZV/7xPrQctJQ93OwfcmRGLYn8C3225iEBghEOgvKyM=;
        b=vPK7pWzFjHC10cAZ90buH8185IrDshtLETMk8WpCc9+zUA3KF9p0dlxxJ7XV5661sdrGej
        6gakVtbBXc2Uz1MwvSXsMpmRCPRnz+lnNJeds2Mz5B15UCvM0Xw/wVu4482ArVIG35VNFd
        bQ4Reqo2f6X12l7FXWzfTbNFgwpwjvWJ5UGnan0kHLc20PQWLxXAWwyy6IBbyawyyprei6
        pt+wQPBsrLvAk/VQZ582Jcye7SuCES+HRWksZS3gimE1ROhzDPqAOayI/Ca6XMNy6GlmAO
        SxflTbWJJEQaJPJj5CyM/3iRtKCD6P2zVzEIKmy6Ju8kkxGK9DjS9BPcTTYqWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605561095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZV/7xPrQctJQ93OwfcmRGLYn8C3225iEBghEOgvKyM=;
        b=F5VlXaw3oVxukFwCkx3QvcWuUTQzThAKPT/BHQbHUP+yh9jyQl1V9gJEAmVuvZgyuUjLGl
        1HeiDWz6nO/Jh2DA==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] x86: Expose syscall_work field in thread_info
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116174206.2639648-2-krisman@collabora.com>
References: <20201116174206.2639648-2-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160556109423.11244.11266299404739212329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     b4581a52caff79eab1ea6caaaa4e08526ce2782b
Gitweb:        https://git.kernel.org/tip/b4581a52caff79eab1ea6caaaa4e08526ce2782b
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 16 Nov 2020 12:41:57 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:53:15 +01:00

x86: Expose syscall_work field in thread_info

This field will be used by SYSCALL_WORK flags, migrated from TI flags.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201116174206.2639648-2-krisman@collabora.com

---
 arch/x86/include/asm/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 06a1710..0da5d58 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -55,6 +55,7 @@ struct task_struct;
 
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 	u32			status;		/* thread synchronous flags */
 };
 
