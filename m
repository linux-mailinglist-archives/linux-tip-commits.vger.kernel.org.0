Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B0258D9A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Sep 2020 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIALth (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Sep 2020 07:49:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgIALs1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:27 -0400
Date:   Tue, 01 Sep 2020 11:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMGlOoCzb2k0yduh1mhM3CVSZIx7WXdMJ+kIVjs8rac=;
        b=Ofqebp0VvLbKpi0maPMUag3Wk5dhHgc1xamrmuM+DxpIvt2P8ammczbCW7ubZnyZ7j1jtW
        tg/+c2RxOoLwKW7pfSSp6M06nVfb4DLog6Nwa614T3wsu+7rWZw77wymLTKjb4D85EE2+L
        0QzU9EjEXey0LYDamIfRVCbSOjtUDkxDW0P73AFgXDEN1f2+4cSgOFZ7LBi88UQwiv0GW3
        2P2Frnf2d08LB9QZ9lAafjJJp39Z3T7hNpjTtTkgumcrz+nNKOm0gDwL0PIsCdb98eE1xH
        HOpUu3smDfOKcIcrulB0Zd0uNrCdHHx79zK+plJkAjKGQ8h47mMXXNeQwkj8KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMGlOoCzb2k0yduh1mhM3CVSZIx7WXdMJ+kIVjs8rac=;
        b=i0vqHD0pn01KlDnM4zO+WsJ7KmoZvQJ5bhFdp21KOKxvGd2AL+FYlgq0z2NL5PQvfKDCaT
        MCBTwB7R21hNdFBQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] x86/build: Add asserts for unwanted sections
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-25-keescook@chromium.org>
References: <20200821194310.3089815-25-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087347.20229.10560541261825230647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     5354e84598f264793265cc99b4be2a2295826c86
Gitweb:        https://git.kernel.org/tip/5354e84598f264793265cc99b4be2a2295826c86
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:43:05 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 10:03:18 +02:00

x86/build: Add asserts for unwanted sections

In preparation for warning on orphan sections, enforce other
expected-to-be-zero-sized sections (since discarding them might hide
problems with them suddenly gaining unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-25-keescook@chromium.org
---
 arch/x86/kernel/vmlinux.lds.S | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4b1b936..45d7244 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -427,6 +427,30 @@ SECTIONS
 	       SIZEOF(.got.plt) == 0xc,
 #endif
 	       "Unexpected GOT/PLT entries detected!")
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.got : {
+		*(.got) *(.igot.*)
+	}
+	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+
+	.plt : {
+		*(.plt) *(.plt.*) *(.iplt)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
+	.rel.dyn : {
+		*(.rel.*) *(.rel_*)
+	}
+	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
+
+	.rela.dyn : {
+		*(.rela.*) *(.rela_*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
 #ifdef CONFIG_X86_32
