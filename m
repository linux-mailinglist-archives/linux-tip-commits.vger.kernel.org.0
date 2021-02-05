Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9FA31082D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Feb 2021 10:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhBEJqN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Feb 2021 04:46:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46600 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhBEJoK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Feb 2021 04:44:10 -0500
Date:   Fri, 05 Feb 2021 09:43:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612518209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmOSBl6fxV6bmim1RfPGpWZJiBIHaqzxi5BfQAFXtj0=;
        b=oJbT+lbKuq+fEZoWrThiUPHvHFltoVxZOdBAQDSHuk1UeC2S43wzfXD+I/FybbXv4dtOAg
        0qgXfzGwNOrvdj6xyzFGxrk7QANIHVz6XFaCgGdMzjapR0l9TeLBP/CPHFSGlZLyBfWo+d
        RNCwEe5HyqVwxj81A6GlT5cG1HihW1oldlG60ueZ4/iaoP6CBbY1FjOZoXine23gQwOYnw
        WMZq3WZBLIEl/KSQ0mEvvFiEDhGWpLYx5WcZndypabt9uOIqGVDjgdsWgaVQrSRJRx5FUT
        GO7XeViGMHp/KTXJ6LxXMedv5EOTzsPN0r8n38cca2Is0cB6VvbLuYQOYfyKjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612518209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmOSBl6fxV6bmim1RfPGpWZJiBIHaqzxi5BfQAFXtj0=;
        b=TOCzkU7M+jrqyKs27b+oGDWe3NXUsabAnBt1/N3CGloHtnLfl3h1RQjj1ibpBJfidKMrhW
        FmmYcNUsGFmwDTAA==
From:   "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm: Fixup TASK_SIZE_MAX comment
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200305181719.GA5490@avx2>
References: <20200305181719.GA5490@avx2>
MIME-Version: 1.0
Message-ID: <161251820804.23325.5778148373565783781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4f63b320afdd9af406f4426b0ff1a2cdb23e5b8d
Gitweb:        https://git.kernel.org/tip/4f63b320afdd9af406f4426b0ff1a2cdb23e5b8d
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Thu, 05 Mar 2020 21:17:19 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 05 Feb 2021 10:37:39 +01:00

x86/asm: Fixup TASK_SIZE_MAX comment

Comment says "by preventing anything executable" which is not true. Even
PROT_NONE mapping can't be installed at (1<<47 - 4096).

  mmap(0x7ffffffff000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM

 [ bp: Fixup to the moved location in page_64_types.h. ]

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200305181719.GA5490@avx2
---
 arch/x86/include/asm/page_64_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 645bd1d..64297ea 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -66,7 +66,7 @@
  * On Intel CPUs, if a SYSCALL instruction is at the highest canonical
  * address, then that syscall will enter the kernel with a
  * non-canonical return address, and SYSRET will explode dangerously.
- * We avoid this particular problem by preventing anything executable
+ * We avoid this particular problem by preventing anything
  * from being mapped at the maximum canonical address.
  *
  * On AMD CPUs in the Ryzen family, there's a nasty bug in which the
