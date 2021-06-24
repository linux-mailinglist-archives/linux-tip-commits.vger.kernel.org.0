Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98A43B2811
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 08:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFXHA1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFXHAW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 03:00:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB1C061574;
        Wed, 23 Jun 2021 23:57:45 -0700 (PDT)
Date:   Thu, 24 Jun 2021 06:57:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624517864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J08rFmLWbs/bmGgTHqht2KHUYXcWs4QXCL7KpuNV+Lo=;
        b=ZoE8Idkp5TmF92qhCALf/vnWFhe2tKuyyLssmDMCC8V7i/1ALVv05AIoqgovOeaQkuii4q
        vJDK76HDDn+NnJnVngLIs87ObCcTgDI3EWILoNI2g3StuVCtpLPZifAFNA3/AaULXpVa72
        GwVzYtsWM8zrRryFhUOEkg7MHA52HWHvvG+U1hRV9OUexLF8vyx1v5XoLQ9+GiYVu48vB5
        3APhgR7TeFdpgsKITJ0PLrPFSg3RTQQmWEVYSiGbRD3NI+tHyz88GTxJmOgwOzl5KXri9x
        AcZYRhd2viKgw58olUPK9rzS69Jg4fL48069h98AnvxDm90HxB80XEV8M5Fy9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624517864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J08rFmLWbs/bmGgTHqht2KHUYXcWs4QXCL7KpuNV+Lo=;
        b=zWIQCtVRwQibC/93IR0a5bWRkPKxaEIxDewYIrUDUrwV0KxGeUB7k2je/BwZ4F+Yr7mSOG
        zeRp2jn7p+vlODAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Don't make .altinstructions writable
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6c284ae89717889ea136f9f0064d914cd8329d31.1624462939.git.jpoimboe@redhat.com>
References: <6c284ae89717889ea136f9f0064d914cd8329d31.1624462939.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <162451786327.395.11993336706320231426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     e31694e0a7a709293319475d8001e05e31f2178c
Gitweb:        https://git.kernel.org/tip/e31694e0a7a709293319475d8001e05e31f2178c
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 23 Jun 2021 10:42:28 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Jun 2021 08:55:20 +02:00

objtool: Don't make .altinstructions writable

When objtool creates the .altinstructions section, it sets the SHF_WRITE
flag to make the section writable -- unless the section had already been
previously created by the kernel.  The mismatch between kernel-created
and objtool-created section flags can cause failures with external
tooling (kpatch-build).  And the section doesn't need to be writable
anyway.

Make the section flags consistent with the kernel's.

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/6c284ae89717889ea136f9f0064d914cd8329d31.1624462939.git.jpoimboe@redhat.com
---
 tools/objtool/arch/x86/decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 523aa41..bc82105 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -684,7 +684,7 @@ static int elf_add_alternative(struct elf *elf,
 	sec = find_section_by_name(elf, ".altinstructions");
 	if (!sec) {
 		sec = elf_create_section(elf, ".altinstructions",
-					 SHF_WRITE, size, 0);
+					 SHF_ALLOC, size, 0);
 
 		if (!sec) {
 			WARN_ELF("elf_create_section");
