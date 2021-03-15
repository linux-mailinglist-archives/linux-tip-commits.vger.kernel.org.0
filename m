Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324AE33C057
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhCOPsU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhCOPr4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:47:56 -0400
Date:   Mon, 15 Mar 2021 15:47:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPawcdfFkv55TerX1/RA1emFXhlwsmKeH/+a9jc29QQ=;
        b=jNl5s5fJYQrguNaXVcEuq+KhpU1GDlDV0/UzVPWuN/3yv9BM/djZZCW64JZTTtXUPMncCp
        cGBcSv8htt1dYvylYUi3bxNY2b8fRgW+lGI4ynhxbPrb1FC0Vz4jFgodHBVSUUiyKrbif7
        FKYh8e++NrCuxgFFZvrHn4pitO8ywl3L0UuF5mjcl7+uExs4q1CQq2mx5sbNBD1apuppHT
        ZBN4XKdL4Fh1oGL4tEoXmYS7yKMkyvUczdhlLp7aakzglDWqQorVqo+145LoZJM4hsYyWz
        a72C83AMPJ7Adv/GUKNAAs9+2dsFlmVZbKLbYwqUlfnxpfpcBiBrT+rRetpN2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPawcdfFkv55TerX1/RA1emFXhlwsmKeH/+a9jc29QQ=;
        b=Gs5ueGmR0rvkzqRPhK8K0pQmcKrQDQ8oO+89W7T15kctSJ0KndApbJ/awP4vyx/1KC3ra9
        QjKR5yk2eBu5g7BA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/tools/insn_decoder_test: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-17-bp@alien8.de>
References: <20210304174237.31945-17-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326531.398.2798335970710554814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0c925c61dae18ee3cb93a61cc9dd9562a066034d
Gitweb:        https://git.kernel.org/tip/0c925c61dae18ee3cb93a61cc9dd9562a066034d
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 20 Nov 2020 15:01:20 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 12:09:09 +01:00

x86/tools/insn_decoder_test: Convert to insn_decode()

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-17-bp@alien8.de
---
 arch/x86/tools/insn_decoder_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 34eda63..472540a 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -120,7 +120,7 @@ int main(int argc, char **argv)
 
 	while (fgets(line, BUFSIZE, stdin)) {
 		char copy[BUFSIZE], *s, *tab1, *tab2;
-		int nb = 0;
+		int nb = 0, ret;
 		unsigned int b;
 
 		if (line[0] == '<') {
@@ -148,10 +148,12 @@ int main(int argc, char **argv)
 			} else
 				break;
 		}
+
 		/* Decode an instruction */
-		insn_init(&insn, insn_buff, sizeof(insn_buff), x86_64);
-		insn_get_length(&insn);
-		if (insn.length != nb) {
+		ret = insn_decode(&insn, insn_buff, sizeof(insn_buff),
+				  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+
+		if (ret < 0 || insn.length != nb) {
 			warnings++;
 			pr_warn("Found an x86 instruction decoder bug, "
 				"please report this.\n", sym);
