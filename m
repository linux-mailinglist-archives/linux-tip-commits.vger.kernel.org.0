Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E627286393
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgJGQUa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:20:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44696 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgJGQUW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:20:22 -0400
Date:   Wed, 07 Oct 2020 16:20:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9PWkpoz1Bhxz8IMpkTJ1TT/ix1qtQEtTBUlV8knttdw=;
        b=oIpGsLGQk5WL2EIBxjF7UtOtC0wO9GE0ezfkKrEQFhD9jvRvU93qiT8FTmDP6gu7dRQKOg
        ChLjLZVoBZxBb1j+tk2aI5NdSNpt2ye4r55eJGiJOix/dR3uuqM8cf/KhfMz5yfD3GlKXS
        oyApZawUbpW5070tTUJ7/1FVKLNkJJQ76PLm/xM22+EtKUcJ9QAb3BIsssrxM28qt/kMbM
        nU6LFF3Qtkvr2a70nis1ZDap7KM2jYlcvpWbii9x96BLSfArL4k5r4BIvNCz95HbRf6oQj
        AB7aKOJQQlKR/7Stuo2jOVF7xlnCMPKEec9LF8Zo+G9mfqetqTHOuXLK1XXHNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9PWkpoz1Bhxz8IMpkTJ1TT/ix1qtQEtTBUlV8knttdw=;
        b=5Ob4DL0il6yj8n/zEwtmf5dP2+Tojuft/ZeL6MIDx9gIKbN37O8CBqNePgig7xgU+jkLQ3
        JhgP34CNJdwkkaDQ==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Allow nested externs to enable BUILD_BUG()
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160208761986.7002.448567990879670641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2486baae2cf6df73554144d0a4e40ae8809b54d4
Gitweb:        https://git.kernel.org/tip/2486baae2cf6df73554144d0a4e40ae8809b54d4
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Mon, 05 Oct 2020 17:50:28 +02:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 06 Oct 2020 09:32:13 -05:00

objtool: Allow nested externs to enable BUILD_BUG()

Currently BUILD_BUG() macro is expanded to smth like the following:
   do {
           extern void __compiletime_assert_0(void)
                   __attribute__((error("BUILD_BUG failed")));
           if (!(!(1)))
                   __compiletime_assert_0();
   } while (0);

If used in a function body this obviously would produce build errors
with -Wnested-externs and -Werror.

Build objtool with -Wno-nested-externs to enable BUILD_BUG() usage.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 33d1e3c..4ea9a83 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -37,7 +37,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/arch/$(SRCARCH)/include	\
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include
-WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
+WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
