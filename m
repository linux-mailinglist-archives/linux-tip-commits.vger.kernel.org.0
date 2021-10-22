Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79743437C5D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhJVSBS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhJVSBS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 14:01:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22FEC061764;
        Fri, 22 Oct 2021 10:59:00 -0700 (PDT)
Date:   Fri, 22 Oct 2021 17:58:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634925537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nhe4mHxk08itAma4b2EHBCAyffbnDrJfV4Yu4cCu7Jw=;
        b=Qh0TCZzAWuAX7SpbU4udtnYMZjgwH3citmlXSzkIxeonN4xoPJf5cigENIeR5di+IOGMez
        bYBupcWqb8GiQOQTJFN7tXQEeAuk7qD7z56B46nvB/KsBwRaG1E/lVwmalbxKmoHRtP6Pt
        y7jxJunRJJavg4Bl5VH6S2D0uRSep91oMCu6ett0JB8AgwrHtPPgIGvYzh2NczuOoLNhUh
        7lQAGyfCsjQ3GcYCJLF2eMABs9V5zdl7VjAeT60MyyE4G4yuV1XLeWxcJxb2/+XrOyOZOI
        SVBBfBhNN5X6CDRGnzhxshSelEa56hH9hwjjgitBuEhv5HSo9ToIuHwIoDDK7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634925537;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nhe4mHxk08itAma4b2EHBCAyffbnDrJfV4Yu4cCu7Jw=;
        b=612pysDJ/9CGQ2MIib3AYHui1dZCF/4kbMtt+4JuP0x1kJhCdeIahPRE70fd7urEUSOVXU
        +5s2B0my+lrmSCBQ==
From:   "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx/virt: extract sgx_vepc_remove_page
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021201155.1523989-2-pbonzini@redhat.com>
References: <20211021201155.1523989-2-pbonzini@redhat.com>
MIME-Version: 1.0
Message-ID: <163492553677.626.4984122142334893368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     fd5128e622d7834bb3f7ee23c2bbea8db63cebaf
Gitweb:        https://git.kernel.org/tip/fd5128e622d7834bb3f7ee23c2bbea8db63cebaf
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Thu, 21 Oct 2021 16:11:54 -04:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 22 Oct 2021 08:30:09 -07:00

x86/sgx/virt: extract sgx_vepc_remove_page

For bare-metal SGX on real hardware, the hardware provides guarantees
SGX state at reboot.  For instance, all pages start out uninitialized.
The vepc driver provides a similar guarantee today for freshly-opened
vepc instances, but guests such as Windows expect all pages to be in
uninitialized state on startup, including after every guest reboot.

One way to do this is to simply close and reopen the /dev/sgx_vepc file
descriptor and re-mmap the virtual EPC.  However, this is problematic
because it prevents sandboxing the userspace (for example forbidding
open() after the guest starts; this is doable with heavy use of SCM_RIGHTS
file descriptor passing).

In order to implement this, we will need a ioctl that performs
EREMOVE on all pages mapped by a /dev/sgx_vepc file descriptor:
other possibilities, such as closing and reopening the device,
are racy.

Start the implementation by creating a separate function with just
the __eremove wrapper.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20211021201155.1523989-2-pbonzini@redhat.com
---
 arch/x86/kernel/cpu/sgx/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 64511c4..59cdf3f 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -111,10 +111,8 @@ static int sgx_vepc_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int sgx_vepc_free_page(struct sgx_epc_page *epc_page)
+static int sgx_vepc_remove_page(struct sgx_epc_page *epc_page)
 {
-	int ret;
-
 	/*
 	 * Take a previously guest-owned EPC page and return it to the
 	 * general EPC page pool.
@@ -124,7 +122,12 @@ static int sgx_vepc_free_page(struct sgx_epc_page *epc_page)
 	 * case that a guest properly EREMOVE'd this page, a superfluous
 	 * EREMOVE is harmless.
 	 */
-	ret = __eremove(sgx_get_epc_virt_addr(epc_page));
+	return __eremove(sgx_get_epc_virt_addr(epc_page));
+}
+
+static int sgx_vepc_free_page(struct sgx_epc_page *epc_page)
+{
+	int ret = sgx_vepc_remove_page(epc_page);
 	if (ret) {
 		/*
 		 * Only SGX_CHILD_PRESENT is expected, which is because of
@@ -144,7 +147,6 @@ static int sgx_vepc_free_page(struct sgx_epc_page *epc_page)
 	}
 
 	sgx_free_epc_page(epc_page);
-
 	return 0;
 }
 
