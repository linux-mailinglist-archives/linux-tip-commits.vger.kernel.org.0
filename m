Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD0C33C05B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhCOPsV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35942 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhCOPr6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:47:58 -0400
Date:   Mon, 15 Mar 2021 15:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FrIbfniDoPToHgCf17eeb0pEs7HcsidpnBDLBxykLI=;
        b=eIHaBWsb70w3+cO/LUtxNb3thmhaV7l5RT8V/3slsKXo4NnxDE+YR83DlR1GJj9sQRXdYx
        Thvrwt+5K8lgkMLgO+NcaL1D+T1qS/Zuk4RGHaFTm32Qt+GtMZD0LTUTmSvJVMXPz0vlF7
        p6LOWyWz6DYq1jPisWcqq/mrl/oPqU/L5ClN4t8FXVeuEfIgbs0/j4tYPpkeUn7ahsa1eW
        PRmKLYnXLJU55tcsgaMOn8luzHviVHA1swAlC+qDxd+He6GNQbdg9dO8pB5fBma1pzLWun
        oTAgCDvrFaR/qmqLWnUPI1F4fO1FQb+IgewmWfaKaQeGXSnn7AK+rF96tjWrgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FrIbfniDoPToHgCf17eeb0pEs7HcsidpnBDLBxykLI=;
        b=cIwDdRo84VqOvlCeOPbAfzJBKr8HSbsVZX6W1AR6Brs9FBCxK2UXUyplR6czQ4RsJPHO94
        eq6PPxu3DVBnpLDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/boot/compressed/sev-es: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-7-bp@alien8.de>
References: <20210304174237.31945-7-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326836.398.15024721671802967704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     514ef77607b9ff184c11b88e8f100bc27f07460d
Gitweb:        https://git.kernel.org/tip/514ef77607b9ff184c11b88e8f100bc27f07460d
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 05 Nov 2020 17:53:20 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:18:35 +01:00

x86/boot/compressed/sev-es: Convert to insn_decode()

Other than simplifying the code there should be no functional changes
resulting from this.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-7-bp@alien8.de
---
 arch/x86/boot/compressed/sev-es.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 27826c2..801c626 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -78,16 +78,15 @@ static inline void sev_es_wr_ghcb_msr(u64 val)
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
+	int ret;
 
 	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
 
-	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
-	insn_get_length(&ctxt->insn);
+	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+	if (ret < 0)
+		return ES_DECODE_FAILED;
 
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	return ES_OK;
 }
 
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
