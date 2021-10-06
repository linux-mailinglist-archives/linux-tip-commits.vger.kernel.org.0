Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DAC424A07
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Oct 2021 00:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhJFWsN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Oct 2021 18:48:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32796 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbhJFWsN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Oct 2021 18:48:13 -0400
Date:   Wed, 06 Oct 2021 22:46:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633560378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEcItxNio8K6x9o/2Y9JoJjLGo0yahl7WgUaCZm9Mew=;
        b=fT6TLm1jTLWSAv/eACQFETDrW7VEaDeCBRk4PtER7uQBWviycKJRpk3Lu32QU5LXbE5hWG
        BQ/mQTHS5865UJI9o6qKtCmQeMLheeGEScm9qQMEHZyn1o5SDjAiU7MK9k80amVqmJQ5h4
        kSo+046eb630LtNYGxpjOpDQz+iaETp0EglUbOp/vJl+lF79Anyx5HYaGBt816zt6C30M9
        rvRKhDX790T1ivYGxMSINSzC59TDxYz3UPlj1cxX6ic6t4z/ai1mlLo4NvYK8L5EHzMcF5
        VTOp322bNdg2ZcsYDC4b95VhEjfDd3yr2F9QfuCGfCAkWSdRZyYV+r4Wtg4W2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633560378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEcItxNio8K6x9o/2Y9JoJjLGo0yahl7WgUaCZm9Mew=;
        b=sFsI9fhWMJjpx4aTHOK8lNw8u/leyXgm10hFdl9tgZlFXpGWs1XSFle1MdpenB8eZH8yqC
        aXeScTZHCFOPwRBA==
From:   "tip-bot2 for Joe Lawrence" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make .altinstructions section entry size
 consistent
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210822225037.54620-2-joe.lawrence@redhat.com>
References: <20210822225037.54620-2-joe.lawrence@redhat.com>
MIME-Version: 1.0
Message-ID: <163356037786.25758.8614363087298524977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     dc02368164bd0ec603e3f5b3dd8252744a667b8a
Gitweb:        https://git.kernel.org/tip/dc02368164bd0ec603e3f5b3dd8252744a667b8a
Author:        Joe Lawrence <joe.lawrence@redhat.com>
AuthorDate:    Sun, 22 Aug 2021 18:50:36 -04:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 05 Oct 2021 12:03:20 -07:00

objtool: Make .altinstructions section entry size consistent

Commit e31694e0a7a7 ("objtool: Don't make .altinstructions writable")
aligned objtool-created and kernel-created .altinstructions section
flags, but there remains a minor discrepency in their use of a section
entry size: objtool sets one while the kernel build does not.

While sh_entsize of sizeof(struct alt_instr) seems intuitive, this small
deviation can cause failures with external tooling (kpatch-build).

Fix this by creating new .altinstructions sections with sh_entsize of 0
and then later updating sec->sh_size as alternatives are added to the
section.  An added benefit is avoiding the data descriptor and buffer
created by elf_create_section(), but previously unused by
elf_add_alternative().

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20210822225037.54620-2-joe.lawrence@redhat.com
Cc: Andy Lavr <andy.lavr@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/objtool/arch/x86/decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index bc82105..0893436 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -684,7 +684,7 @@ static int elf_add_alternative(struct elf *elf,
 	sec = find_section_by_name(elf, ".altinstructions");
 	if (!sec) {
 		sec = elf_create_section(elf, ".altinstructions",
-					 SHF_ALLOC, size, 0);
+					 SHF_ALLOC, 0, 0);
 
 		if (!sec) {
 			WARN_ELF("elf_create_section");
