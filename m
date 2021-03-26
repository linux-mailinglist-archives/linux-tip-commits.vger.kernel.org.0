Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C0634A7E2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Mar 2021 14:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCZNOG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Mar 2021 09:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCZNNf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Mar 2021 09:13:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E67C0613AA;
        Fri, 26 Mar 2021 06:13:34 -0700 (PDT)
Date:   Fri, 26 Mar 2021 13:13:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616764411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlR1tpuRhM8dVRnfgL93cqZK0Z1CqVDXXnxeP0qLgmU=;
        b=qHchOfXBeos+rMcSpWWC51x5Tw5LTJxUV8pEsyMATl/+3XAySdsY+9ZQ4/60AV89GDcYhq
        Hu+mRPEohpbvSHC1VKdpUMIDsioeJmAB4uRJSExqGYfu2+cflxtjQBL+pDejqRZ4u1Rfxy
        asdKqJbRDCSp2OnwMTdJg8wqGqPcR8A/offpSHLU3g+Oa/0YdQ4CAkUh6NuE+lnfhWDyEM
        bLuQ0oS0F/BeHDB+n0bKD2+LEh30opfeSrGeqQJG45loE+myB+egKQdIzQ5tINI+bKPToG
        dgi9fS1mGE2+1qC9gMeNouO6FEnIWa3JOEQ5CkutJJgj78qnEiTGxbl38rVycA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616764411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlR1tpuRhM8dVRnfgL93cqZK0Z1CqVDXXnxeP0qLgmU=;
        b=WcqJQUX4+uVeRgi1ZOHRxGTEnIWRIJpgAtqQn9a85VoYWR5ZKFdSkaI7QNhFuE4DBjKUhC
        IsWT0B0196v8LUCA==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/boot: Add $(CLANG_FLAGS) to compressed KBUILD_CFLAGS
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326000435.4785-3-nathan@kernel.org>
References: <20210326000435.4785-3-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <161676441048.398.6354341807267354566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     d5cbd80e302dfea59726c44c56ab7957f822409f
Gitweb:        https://git.kernel.org/tip/d5cbd80e302dfea59726c44c56ab7957f822409f
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 25 Mar 2021 17:04:34 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 26 Mar 2021 11:32:55 +01:00

x86/boot: Add $(CLANG_FLAGS) to compressed KBUILD_CFLAGS

When cross compiling x86 on an ARM machine with clang, there are several
errors along the lines of:

  arch/x86/include/asm/string_64.h:27:10: error: invalid output constraint '=&c' in asm

This happens because the compressed boot Makefile reassigns KBUILD_CFLAGS
and drops the clang flags that set the target architecture ('--target=')
and the path to the GNU cross tools ('--prefix='), meaning that the host
architecture is targeted.

These flags are available as $(CLANG_FLAGS) from the main Makefile so
add them to the compressed boot folder's KBUILD_CFLAGS so that cross
compiling works as expected.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20210326000435.4785-3-nathan@kernel.org
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index e0bc398..6e5522a 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -46,6 +46,7 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
 KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
+KBUILD_CFLAGS += $(CLANG_FLAGS)
 
 # sev-es.c indirectly inludes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
