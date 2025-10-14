Return-Path: <linux-tip-commits+bounces-6800-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E61DCBD91AD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7051F50003A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA863101BC;
	Tue, 14 Oct 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6g56Wgx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wBUJ1wbj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC92310652;
	Tue, 14 Oct 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442482; cv=none; b=kAwEcnGSVq4To00aVpiblMjHH4BoVMr3tc23wYops5ZjEvPNHOdgghcO02qzlYMYms4+0kVgdsL1sPLgnC1Z0ENASUuOvTguelvKBUE8I0SejkieEzmISUtRXHpiWcQi08NrHpyP7h3kKcrBNn2NG1GHKJk+aclI06YfZay3UN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442482; c=relaxed/simple;
	bh=fNq7rd230xqXNjNJ1tejhtCVxS2sQZ2+Z/XSmmIv4gA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=szS86BZ87nyKb58Pqbk1B51hP8c/6IfGD8LQ/5M0bTIQnWg7pLkSYdhk4rXGxY+1FC1Iz1qR+OarykSdDm7e65mNQPdt75HRVYieOXwDIFPi1Sm2DPmREJWSasY88fk0pPcc5FBiz+W9ZrAKFTmVGr41lCpGhiOgQ1z3ymQ3bXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C6g56Wgx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wBUJ1wbj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 11:47:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760442478;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fadyyxWQq7qpor//WisLPUZ/tILl8OJQB/M6teZoX2A=;
	b=C6g56Wgx3BcDbFhQH4A15ZBUxRv2XEskNfKtxA93gft0rKXqPhY5rxtlg3vA3Qrj73rs2B
	Iy4zI/so17Qu37AADHRaNiEGp77ndyC6EbAK63B8nhpG+75PzwFjEUrlEpIEqj+4qYr0Zc
	T/FOoH5UUTNPn5aYdWuAS2pR7jKznb4UGhUerq8rHQ8dWOF1uLSq1b0bh2I/eWzx9KdAWP
	qP5GTlK8O5kiC6xtOk/Qk/eUkECHURVcHWoNNOomLgpfKt4hQH5t3N4NMAYuhQOm8vfqmp
	H1zPGPwBlHWyjajLllcVY/MxUU7XFDP6Z2+ngXWJgdDeQG7E39vAouG4KVJhoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760442478;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fadyyxWQq7qpor//WisLPUZ/tILl8OJQB/M6teZoX2A=;
	b=wBUJ1wbjB61r0rVORQAdzS3mCRjSlNjzhhpaR79PvBq5Pk/5mygcHnOF8d7FlDDagUXA2f
	hg1U5Eo3lmp/+mCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/x86: Add UDB support
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924134644.027686159@infradead.org>
References: <20250924134644.027686159@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176044247750.709179.8482885603845997240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     76e1851a1bc28e760d6acc7a54ec9dce05717028
Gitweb:        https://git.kernel.org/tip/76e1851a1bc28e760d6acc7a54ec9dce057=
17028
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Sep 2025 15:25:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 13:43:11 +02:00

objtool/x86: Add UDB support

Per commit 85a2d4a890dc ("x86,ibt: Use UDB instead of 0xEA"), make
sure objtool also recognises UDB as a #UD instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/x86/decode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index ce16fb2..ef6e96d 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -683,6 +683,10 @@ int arch_decode_instruction(struct objtool_file *file, c=
onst struct section *sec
 		insn->type =3D INSN_SYSRET;
 		break;
=20
+	case 0xd6: /* udb */
+		insn->type =3D INSN_BUG;
+		break;
+
 	case 0xe0: /* loopne */
 	case 0xe1: /* loope */
 	case 0xe2: /* loop */

