Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1FB298D35
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775671AbgJZMwk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:52:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39830 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775662AbgJZMwj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:39 -0400
Date:   Mon, 26 Oct 2020 12:52:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Rqeto/78InwKJzU7bGqoAEw5BDhCuPHB0mKAB98Bt4=;
        b=iUcE6o1g20eAircKAMgrK2paVuCTBohGopJ8eDJNP/IpRaZuzhnw9U/+vXK/hyWtmb4TbB
        YLzLEw0I317qZqLhcIfbtSzDoqXc02NuqJ91jLVq8a7j8w3MUHoAppwhMmBJ7bn6TTOmdD
        YARPiGtr7knr8b+aWwdvNJhtiVhgn51f/GeFnee57vqzrhE/Y0sMuGb13XCoAKmhYCKerZ
        IaD7yXqFNlDRQHFTATa+OM+T5R/lT/VCvzsvD8OECgfKJQ2GxHTP0zO4oRD0iOd08F6ngI
        BmE6C7S+1YBrGV2wyc5vrsrWPShFODufMu85FWSTzR1dbdQ2mwCRzPMf6jTbyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Rqeto/78InwKJzU7bGqoAEw5BDhCuPHB0mKAB98Bt4=;
        b=kaKbR38ZDekV66+6ZAGnSL/g5A6pfTHRzQkRYI8nwP/+aQo4CNBfRNR5xkkQ/c1/GatZjQ
        JJ20a6p1PiTf9BDA==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/elf: Use e_machine to choose DLINFO in compat
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-5-krisman@collabora.com>
References: <20201004032536.1229030-5-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675602.397.8513905247826263985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     2656af0d5abfa26d7f1e40f92e9953fe155b950a
Gitweb:        https://git.kernel.org/tip/2656af0d5abfa26d7f1e40f92e9953fe155b950a
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:30 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:46 +01:00

x86/elf: Use e_machine to choose DLINFO in compat

Since TIF_X32 is going away, avoid using it to find the ELF type on
ARCH_DLINFO.

According to SysV AMD64 ABI Draft, an AMD64 ELF object using ILP32 must
have ELFCLASS32 with (E_MACHINE == EM_X86_64), so use that ELF field to
differentiate a x32 object from a IA32 object when loading ARCH_DLINFO in
compat mode.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201004032536.1229030-5-krisman@collabora.com

---
 arch/x86/include/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index b9a5d48..9220efc 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -361,7 +361,7 @@ do {									\
 #define AT_SYSINFO		32
 
 #define COMPAT_ARCH_DLINFO						\
-if (test_thread_flag(TIF_X32))						\
+if (exec->e_machine == EM_X86_64)					\
 	ARCH_DLINFO_X32;						\
 else									\
 	ARCH_DLINFO_IA32
