Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCB0264DF2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 20:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIJS4x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 14:56:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgIJSzG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:06 -0400
Date:   Thu, 10 Sep 2020 18:54:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qldr24ZABIko766Gx//VbWWMqXYF18LhWtWeiqzwtIw=;
        b=jisq6GbOJAxMIKv5XxZCD8bMLvfzZz82EXUOiy7xgs5aLA9KCqlZD5sEMJPLUTf3KjxE+/
        NE9ROqdj5qCGYDpulaaDq/mqCmCJMUc5wi1OMLuBzSGFW1WY1gvpla8HD8h6WWq7EGlfrE
        1+Y6lOqPRpftbOK6+PA+TXv+HlpH7MlVPwvjtCznBpGtBDCrya8IbJEOKV01+K9uHhnsMG
        7JnI/6QhbsEzc7mn+omGDmy8cTyLlJeGT3Cj1Kbd2iWkB8nSy0r8+aav7qHUVKtwRjwuBd
        P8d5+LNYbMocPUczk6ww9onyoyWTr+l2zg3tXi1k0gaMj6WF4qp2B/v+hulCBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Qldr24ZABIko766Gx//VbWWMqXYF18LhWtWeiqzwtIw=;
        b=aY6r3Pg0mjUbqere7IyZn4fFIZL/DDInioK6lPanDnrj3fk1eVfhVmhhcwNNGaburh7aVj
        hT2hu+jo5OjglkBw==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Skip ORC entry creation for non-text sections
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407967.20229.8320651008758701134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3eaecac88a17f7fdf29561a197dc728f7f697c60
Gitweb:        https://git.kernel.org/tip/3eaecac88a17f7fdf29561a197dc728f7f697c60
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Tue, 25 Aug 2020 13:47:41 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 01 Sep 2020 17:19:11 -05:00

objtool: Skip ORC entry creation for non-text sections

Orc generation is only done for text sections, but some instructions
can be found in non-text sections (e.g. .discard.text sections).

Skip setting their orc sections since their whole sections will be
skipped for orc generation.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/orc_gen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index e6b2363..22fe439 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -18,6 +18,9 @@ int create_orc(struct objtool_file *file)
 		struct cfi_reg *cfa = &insn->cfi.cfa;
 		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
 
+		if (!insn->sec->text)
+			continue;
+
 		orc->end = insn->cfi.end;
 
 		if (cfa->base == CFI_UNDEFINED) {
