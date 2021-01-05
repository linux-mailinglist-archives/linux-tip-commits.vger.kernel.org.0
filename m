Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD7A2EB205
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Jan 2021 19:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhAESGC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Jan 2021 13:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbhAESGC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Jan 2021 13:06:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3983C061793;
        Tue,  5 Jan 2021 10:05:21 -0800 (PST)
Date:   Tue, 05 Jan 2021 18:05:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609869919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+v5mLEInRf1Dnm3NFSWVVN0dQUTBpU53ZdB5qcd5go=;
        b=yRTSFzAgucekhdmIxAVfE9Z5stKMuJTjQ+cWziwmtYHvfbz5wf6Qo54Tqlps8BxtRq1dcS
        Z2RvC7DjBWaRzz1fQMPZv6klT9iagqBfdWQ1Dpgnau8nfq6vZm03K3GpOjVI1PfBoOLJgH
        n9HvtwCfEpV2G1Bl1tvtf5c9AQEbWa+tLauTa0ZOa3WAPbmYC1/cLkN0fGYYVfjjTynZ57
        5Amx0uX3/C+jcQQ0JCyLbaEE45boF2fs4vPEzc/Lrc7BIAWbyd35QnGhnwftX3vE7WFfNi
        CJSWbRadFHhlGagGAfe1qt7Akxk7zjC27N+G1V+mbqbDFrq0GuijZhqPpE67gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609869919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+v5mLEInRf1Dnm3NFSWVVN0dQUTBpU53ZdB5qcd5go=;
        b=rmqPYYRHdzarDpnRbZsFd9ZyUJNif435XwpGFR1NBUfGcq7QsiWhI0l3YI88PCOn8K9s5x
        8UcSaQL8nQu75lDw==
From:   "tip-bot2 for Peter Gonda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc handling
Cc:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        David Rientjes <rientjes@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210105163311.221490-1-pgonda@google.com>
References: <20210105163311.221490-1-pgonda@google.com>
MIME-Version: 1.0
Message-ID: <160986991879.414.1361812669618654392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a8f7e08a81708920a928664a865208fdf451c49f
Gitweb:        https://git.kernel.org/tip/a8f7e08a81708920a928664a865208fdf451c49f
Author:        Peter Gonda <pgonda@google.com>
AuthorDate:    Tue, 05 Jan 2021 08:33:11 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Jan 2021 18:55:00 +01:00

x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc handling

The IN and OUT instructions with port address as an immediate operand
only use an 8-bit immediate (imm8). The current VC handler uses the
entire 32-bit immediate value but these instructions only set the first
bytes.

Cast the operand to an u8 for that.

 [ bp: Massage commit message. ]

Fixes: 25189d08e5168 ("x86/sev-es: Add support for handling IOIO exceptions")
Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: David Rientjes <rientjes@google.com>
Link: https://lkml.kernel.org/r/20210105163311.221490-1-pgonda@google.com
---
 arch/x86/kernel/sev-es-shared.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 7d04b35..cdc04d0 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -305,14 +305,14 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	case 0xe4:
 	case 0xe5:
 		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (u64)insn->immediate.value << 16;
+		*exitinfo |= (u8)insn->immediate.value << 16;
 		break;
 
 	/* OUT immediate opcodes */
 	case 0xe6:
 	case 0xe7:
 		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (u64)insn->immediate.value << 16;
+		*exitinfo |= (u8)insn->immediate.value << 16;
 		break;
 
 	/* IN register opcodes */
