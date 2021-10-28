Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2002343E97F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Oct 2021 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJ1UYG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Oct 2021 16:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ1UYG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Oct 2021 16:24:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FFC061570;
        Thu, 28 Oct 2021 13:21:38 -0700 (PDT)
Date:   Thu, 28 Oct 2021 20:21:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635452496;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Blq1AwWhYvhwCCGN1aBK9iaYJneDchBYmy/LlJwsNHA=;
        b=PJ0I4vgXgy55MdsBKBZyLu/wYfJ5qyhFumB/5UCbUucv7/zDUPZAAXAwKLaiy5sNqAqxLY
        xhXeEB4e/I/2CxcvOa+TE2u2Vxu1ycvzx8njXU645FG6Ko4o2GVcKyjiEs4C3MZSTqt80W
        7k13KC1fx7LjvXAD7WSJ+RlR+hwnbJFvVbv/M31NlOUFDgd/iEM2scIb2VxAhALfg3u8wp
        kBuBZ4NkY2wyDtOpjTSDLqw6XnSjfvjG3XuKbR3vTMC/6PFm00hoAf64vq6CpvSR1hAQx8
        Yy/nxmVjJM+W906g92xa2QZSRXs7yJUOwJjv9Q66HAGelzbZtg8hD3jgjc3R6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635452496;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Blq1AwWhYvhwCCGN1aBK9iaYJneDchBYmy/LlJwsNHA=;
        b=9eIzEvaWhatZGbNlsxHZ3kLEEng8jWl5tjrx2O6JT/i+M5joV8c06jkCPZl7UF/6IPJM4Q
        hOtrM3KEmYycvLCA==
From:   "tip-bot2 for Elyes HAOUAS" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/Makefile: Remove unneeded whitespaces before tabs
Cc:     Elyes HAOUAS <ehaouas@noos.fr>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211028121021.10384-1-ehaouas@noos.fr>
References: <20211028121021.10384-1-ehaouas@noos.fr>
MIME-Version: 1.0
Message-ID: <163545249521.626.14635322538824694773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     a757ac555ce1dafca848aa090b66cd04b5ce40e7
Gitweb:        https://git.kernel.org/tip/a757ac555ce1dafca848aa090b66cd04b5ce40e7
Author:        Elyes HAOUAS <ehaouas@noos.fr>
AuthorDate:    Thu, 28 Oct 2021 14:10:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 28 Oct 2021 20:19:13 +02:00

x86/Makefile: Remove unneeded whitespaces before tabs

Align the FDINITRD line to the FDARGS one with tabs.

 [ bp: Commit message. ]

Signed-off-by: Elyes HAOUAS <ehaouas@noos.fr>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211028121021.10384-1-ehaouas@noos.fr
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7488cfb..aab7041 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -299,7 +299,7 @@ define archhelp
   echo  '  isoimage		- Create a boot CD-ROM image (arch/x86/boot/image.iso)'
   echo  '			  bzdisk/fdimage*/hdimage/isoimage also accept:'
   echo  '			  FDARGS="..."  arguments for the booted kernel'
-  echo  '                  	  FDINITRD=file initrd for the booted kernel'
+  echo  '			  FDINITRD=file initrd for the booted kernel'
   echo  ''
   echo  '  kvm_guest.config	- Enable Kconfig items for running this kernel as a KVM guest'
   echo  '  xen.config		- Enable Kconfig items for running this kernel as a Xen guest'
