Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6566742C0B4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Oct 2021 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhJMM6k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Oct 2021 08:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbhJMM6k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Oct 2021 08:58:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3380AC061570;
        Wed, 13 Oct 2021 05:56:37 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:56:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634129794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrIeds/TVlfcjqsL7Y2yNbwNao3EblKRHIG8Z7Kz18I=;
        b=P69m9Lvio5hD2hin7wd8KOIH+4VVEI7Z0xnjYfJGebuB5YyOgGeHGP9+JMiDMshgrwa5Ho
        CWLSTUGUsltUuyp/vrXcA4lGbo2omMdE2dzudCP9bssH6L+L9ctXVHmzTlx4RiEJVLyi92
        kcR7xcQVHJ3sxvNfQghuF4QSF2tr10UtJg6OwmbztPS93P5lBwCsr6QHRJsMeY9pxezaFG
        26u0xqpxUfil+cmsdVJcFj3fSd8Jk0FfmpIl3wJrGUT27ai4O6qfq+JQNrwoTg3b5r95TN
        zRxcXvdZnDXR+OaARmLaa2aQmF+ptHIMgcYNMnNUJ5B7/wmraT9lVf34f9MNrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634129794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrIeds/TVlfcjqsL7Y2yNbwNao3EblKRHIG8Z7Kz18I=;
        b=QoVFLucd/jWjmzuTwgMzhwlZxEmJ5oN0c994NXxokZP6IqZjAbwQqAooarVSBqKzD4uJsW
        Dj96ZEzI70dYmbBw==
From:   "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx/virt: Extract sgx_vepc_remove_page()
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211012105708.2070480-2-pbonzini@redhat.com>
References: <20211012105708.2070480-2-pbonzini@redhat.com>
MIME-Version: 1.0
Message-ID: <163412979365.25758.7879693193208918421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     33633b20e0da301f9009cc9aa00282acbc282a1f
Gitweb:        https://git.kernel.org/tip/33633b20e0da301f9009cc9aa00282acbc282a1f
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Tue, 12 Oct 2021 06:57:07 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 13 Oct 2021 11:57:44 +02:00

x86/sgx/virt: Extract sgx_vepc_remove_page()

For bare-metal SGX on real hardware, the hardware provides guaranteed
SGX state at reboot.  For instance, all pages start out uninitialized.
The vepc driver provides a similar guarantee today for freshly-opened
vepc instances, but guests such as Windows expect all pages to be in
uninitialized state on startup, including after every guest reboot.

One way to do this is to simply close and reopen the /dev/sgx_vepc file
descriptor and re-mmap the virtual EPC.  However, this is problematic
because it prevents sandboxing the userspace (for example forbidding
open() after the guest starts; this is doable with heavy use of SCM_RIGHTS
file descriptor passing).

In order to implement this, an ioctl will be needed that performs
EREMOVE on all pages mapped by a /dev/sgx_vepc file descriptor: other
possibilities, such as closing and reopening the device, are racy.

Start the implementation by creating a separate function with just
the __eremove() wrapper.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/20211012105708.2070480-2-pbonzini@redhat.com
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
 
