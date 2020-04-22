Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531FD1B5021
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDVWZF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 18:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgDVWZE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 18:25:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBF1C03C1A9;
        Wed, 22 Apr 2020 15:25:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnV-0001RO-7L; Thu, 23 Apr 2020 00:24:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 612751C04D1;
        Thu, 23 Apr 2020 00:24:45 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:44 -0000
From:   "tip-bot2 for Sami Tolvanen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Use sh_info to find the base for .rela sections
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158759428485.28353.15005772572257518607.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e2ccbff8f02d6b140b8ee71108264686c19b1c78
Gitweb:        https://git.kernel.org/tip/e2ccbff8f02d6b140b8ee71108264686c19b1c78
Author:        Sami Tolvanen <samitolvanen@google.com>
AuthorDate:    Tue, 21 Apr 2020 11:25:01 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 21 Apr 2020 18:49:15 -05:00

objtool: Use sh_info to find the base for .rela sections

ELF doesn't require .rela section names to match the base section. Use
the section index in sh_info to find the section instead of looking it
up by name.

LLD, for example, generates a .rela section that doesn't match the base
section name when we merge sections in a linker script for a binary
compiled with -ffunction-sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c4857fa..c20dfe1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -468,7 +468,7 @@ static int read_relas(struct elf *elf)
 		if (sec->sh.sh_type != SHT_RELA)
 			continue;
 
-		sec->base = find_section_by_name(elf, sec->name + 5);
+		sec->base = find_section_by_index(elf, sec->sh.sh_info);
 		if (!sec->base) {
 			WARN("can't find base section for rela section %s",
 			     sec->name);
