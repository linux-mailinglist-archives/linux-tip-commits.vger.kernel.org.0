Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB7A57347E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jul 2022 12:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiGMKpL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Jul 2022 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiGMKpK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Jul 2022 06:45:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A562F9907;
        Wed, 13 Jul 2022 03:45:10 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:45:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657709108;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V8DARu14SdouI1aP70tIrihlQVvaTbCqD0sVqIaLFrA=;
        b=aTCr6zrODzn9hCSbB2HIgHiR2tj7Nyw4lCmScSKjJuL+snY9YwTUfvSUNVgVVZIWXOcMoK
        wFYDhtMkmub5KHuNhDaBjIHitZwh2Krbsj+oTB/HGugkaCy7ZeH/89ajb+dr15++/huzn7
        jvBuvRxlH0RqXXIJDc0erqNzw3vdJ8ktnFE48VGBCaetGr+GZXh6up7cH+mBTqqEVqY1eL
        fJTvwkgABuw55aYFERuBc4LxD1fDqXrRtQXIaL82Wu7zYoVCGWzEQUrgSEbHURSDW/j8fC
        YDcHXxTFSA98uTgp+tnyhSv1cI90QrLVR3Ed5X+W7FBWLLnGjPW2Qf5OqS+djQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657709108;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V8DARu14SdouI1aP70tIrihlQVvaTbCqD0sVqIaLFrA=;
        b=PMpZzmyiqC5S1i8XhwcDWPuQ2ANiRu3nanggxbaQb+xXPFqaeDoRQqysOpJzNSaY1YXHyk
        UPUkZFqloPqehPBw==
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/asm/32: Fix ANNOTATE_UNRET_SAFE use on 32-bit
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <63e23f80-033f-f64e-7522-2816debbc367@kernel.org>
References: <63e23f80-033f-f64e-7522-2816debbc367@kernel.org>
MIME-Version: 1.0
Message-ID: <165770910773.15455.14083079054575719536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     56453410313828bf4eb70f3efbf7e2b29d6c647a
Gitweb:        https://git.kernel.org/tip/56453410313828bf4eb70f3efbf7e2b29d6c647a
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Wed, 13 Jul 2022 11:50:46 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 13 Jul 2022 12:20:42 +02:00

x86/asm/32: Fix ANNOTATE_UNRET_SAFE use on 32-bit

The build on x86_32 currently fails after commit

  9bb2ec608a20 (objtool: Update Retpoline validation)

with:

  arch/x86/kernel/../../x86/xen/xen-head.S:35: Error: no such instruction: `annotate_unret_safe'

ANNOTATE_UNRET_SAFE is defined in nospec-branch.h. And head_32.S is
missing this include. Fix this.

Fixes: 9bb2ec608a20 (objtool: Update Retpoline validation)
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/63e23f80-033f-f64e-7522-2816debbc367@kernel.org
---
 arch/x86/kernel/head_32.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index eb8656b..9b7acc9 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -23,6 +23,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/percpu.h>
 #include <asm/nops.h>
+#include <asm/nospec-branch.h>
 #include <asm/bootparam.h>
 #include <asm/export.h>
 #include <asm/pgtable_32.h>
