Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2179434C58
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJTNqs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhJTNqq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E0AC061746;
        Wed, 20 Oct 2021 06:44:31 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:44:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpFmICF4RbeDqxKn2cW+y36CzQXwHXbHG24APH+wpJE=;
        b=FZXVcfTvN4tqHQMpUEYlxUWhBKZgBZNIRXL+GAm65ZTu9BBl5I6+vP9GDadgus0wlj/LwQ
        VHr1tgyk+IgNyM4XY9G4jo6FCWL4A3cFSviw/WDsx10VWzrnR1cmLwF+z+/O/u6fvNnfAK
        nWVRCZy3mZzMPbTRssITRWGh9oefeVXwcAzj+Tm3UuOWMgSyGcWEQEZmndee1jRMzHn2Ld
        dI7y05RlpZLkc4oChEgn8qNTYwC1C7b2oWEcbMZYnaIguO/syGFXAbrx8sA9hFryBKE4bu
        1uY4BGW5JaAE9Wz5gHlTHmFrwouO0ZZRYF01eXIbuX7hOOJ3DI+wW8W3pMoNHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpFmICF4RbeDqxKn2cW+y36CzQXwHXbHG24APH+wpJE=;
        b=K3U4Gx0rD6fS/psI/MgE1gwQdPvnvwKSD2HpRhMkOL/nZrxoMXOXBqDH/YZNADlmlTdft/
        KhOrL1KihRz+BFBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/sev: Include fpu/xcr.h
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.896573039@linutronix.de>
References: <20211015011539.896573039@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473746934.25758.16536655234941220697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ff0c37e191f2629bf2776dbd95db5d06f704ab93
Gitweb:        https://git.kernel.org/tip/ff0c37e191f2629bf2776dbd95db5d06f704ab93
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:36 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:29 +02:00

x86/sev: Include fpu/xcr.h

Include the header which only provides the XCR accessors. That's all what
is needed here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.896573039@linutronix.de
---
 arch/x86/kernel/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e4..50c773c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -23,7 +23,7 @@
 #include <asm/stacktrace.h>
 #include <asm/sev.h>
 #include <asm/insn-eval.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/xcr.h>
 #include <asm/processor.h>
 #include <asm/realmode.h>
 #include <asm/traps.h>
