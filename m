Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211F7287123
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Oct 2020 11:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgJHJBd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Oct 2020 05:01:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49196 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHJBd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Oct 2020 05:01:33 -0400
Date:   Thu, 08 Oct 2020 09:01:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602147690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=durKiTlB47YIdyvZ39mwAzI/Jri1OZ66NuaWMy09ZfU=;
        b=KnyRGYVYkccpu5OrYl7XvxrnkTzP+T3Idn4pFsU86QCsTOh8ET7wej+grxFAU2s6FEp9aQ
        aH9F9o7S0RDHy47MkSu45PcmoEDIq/CW3NojwCUrX9hqn52nZwKQIhIYD7xst3tjpEoYSm
        Lo73hbIRXIFGOWvuKevEfDU/9gBmrtWEywiDjvaeI07Sh6ohvT1cSBDl163vrq6xttHqyC
        toXPKoK1DXoRJ/68SloVGVyTE558zpkgyo1Mh3Vf4hQjVjDBi4i80bzJrLphetvyUt7dfl
        sUrvtrN4m36zTHTioQY0Rc4c8SdZvmwCNnLfiiD8KmeD2rCwdKplpuNcda/DlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602147690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=durKiTlB47YIdyvZ39mwAzI/Jri1OZ66NuaWMy09ZfU=;
        b=Lwt09hNFkyutJqKs0ovTK9Ge4A7JrPfUMFzhRpAgsr26RlR7T/ALdU/yhAvX9jpAYqWTL4
        b1e0K1l3gz9DMODg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Allow for copy_mc_fragile symbol checksum to
 be generated
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201007111447.GA23257@zn.tnic>
References: <20201007111447.GA23257@zn.tnic>
MIME-Version: 1.0
Message-ID: <160214768965.7002.13479051629988685867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     b3149ffcdb31a8eb854cc442a389ae0b539bf28a
Gitweb:        https://git.kernel.org/tip/b3149ffcdb31a8eb854cc442a389ae0b539bf28a
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 07 Oct 2020 18:55:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 08 Oct 2020 10:39:21 +02:00

x86/mce: Allow for copy_mc_fragile symbol checksum to be generated

Add asm/mce.h to asm/asm-prototypes.h so that that asm symbol's checksum
can be generated in order to support CONFIG_MODVERSIONS with it and fix:

  WARNING: modpost: EXPORT symbol "copy_mc_fragile" [vmlinux] version \
	  generation failed, symbol will not be versioned.

For reference see:

  4efca4ed05cb ("kbuild: modversions for EXPORT_SYMBOL() for asm")
  334bb7738764 ("x86/kbuild: enable modversions for symbols exported from asm")

Fixes: ec6347bb4339 ("x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user, kernel}()")
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201007111447.GA23257@zn.tnic
---
 arch/x86/include/asm/asm-prototypes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 5a42f92..51e2bf2 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -5,6 +5,7 @@
 #include <asm/string.h>
 #include <asm/page.h>
 #include <asm/checksum.h>
+#include <asm/mce.h>
 
 #include <asm-generic/asm-prototypes.h>
 
