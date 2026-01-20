Return-Path: <linux-tip-commits+bounces-8078-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LZ3C7pVcGlvXQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8078-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 05:27:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04B51020
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 05:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 073FB64994F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jan 2026 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEC2427A1D;
	Tue, 20 Jan 2026 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nb5VzOaq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oiNUuLPz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010A425CC2;
	Tue, 20 Jan 2026 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910891; cv=none; b=KzZWiMaI6C5Di1iZp2izhQnR9bTovUOO0Sv2KbFZx7pRDXX2EMEUfCJeLdDwOi/AbQi8CIQZR6qIBuWVbF1Fsi/ii9+67MNAM/jaWrdjEyUHYipLH0ImGjlmrdHNweYx9mzJVMtmxx6CzXot85IpeNKVDeEjDtPLEkxPRAJC26U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910891; c=relaxed/simple;
	bh=FMmNcgeD+XtT4L7eTxEYPqrd2SuHvAJx4GtKMHiar5Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YTGjfvpAfQlaXbmd279xCpIqQ138zAwLH2x+vhMV7PrP33C871ZukCJ8uNetuqAiHNN+fWsnMHngi6tYbCdlh/9A+LnXswowLky9BZPesoLPlHChtmVJGcjsf53ZJRqzKjvu0dUCkgbc7QKAjkxqeGtl+X9zaaSGNglosfurYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nb5VzOaq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oiNUuLPz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Jan 2026 12:08:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768910883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOq5y2FS2ZFLMZbpDlgrHEK37UG1yjJ0vShsFNED83M=;
	b=Nb5VzOaqDJBOXTvHksLPLRDo2o5swRLaZnn6r03TTCd4d0jOi5TsnwirK/4AXrHf3yvgBx
	RtT2wxWTyJ/iCEqzgvggarQj5z0tMTgUyodBEITxgyh1J2TGS6g9QHke5iiUC77Fo5rUsg
	QmBmw8y9Hr++dD5USl7Q/+okFIJcyOMYPG0OiTjrnMjnHMvrDmEvighRgkxc967tHfiJR7
	9HaJvZKlzV52Ol2HhvlW8EqwyPnLWJ2IYUeBldJAfT/7CZNUedTNUOUQ9b7MQe+UnWNLXj
	aaumNxRZvKSDOIdmVRHnhLEfiwnahoBaSFfiBSVbdt7GDdVpSnyF6pdoGf6i9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768910883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOq5y2FS2ZFLMZbpDlgrHEK37UG1yjJ0vShsFNED83M=;
	b=oiNUuLPzB6EUh8dMdAV1cJIA16PDf1Tcf8IqEBpY1jxv/aQUYludKW0mTH2MIeet20bwaO
	ryAhBnHZAjxUc6CQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/segment: Use MOVL when reading segment registers
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Michael Kelley <mhklinux@outlook.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105090422.6243-1-ubizjak@gmail.com>
References: <20260105090422.6243-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176891088183.510.8607818928752445249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8078-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,alien8.de,zytor.com,outlook.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,vger.kernel.org:replyto,outlook.com:email,alien8.de:email,zytor.com:email]
X-Rspamd-Queue-Id: AD04B51020
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     53ed3d91a141f5c8b3bce45b0004fbbfefe77956
Gitweb:        https://git.kernel.org/tip/53ed3d91a141f5c8b3bce45b0004fbbfefe=
77956
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 05 Jan 2026 10:02:32 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 20 Jan 2026 12:34:58 +01:00

x86/segment: Use MOVL when reading segment registers

Use MOVL when reading segment registers to avoid 0x66 operand-size override
insn prefix. The segment value is always 16-bit and gets zero-extended to the
full 32-bit size.

Example:

  4e4:       66 8c c0                mov    %es,%ax
  4e7:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)

  4e4:       8c c0                   mov    %es,%eax
  4e6:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)

Also, use the %k0 modifier which generates the SImode (signed integer)
register name for the target register.

  [ bp: Extend and clarify commit message. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/20260105090422.6243-1-ubizjak@gmail.com
---
 arch/x86/include/asm/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index f59ae71..9f5be2b 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned short value)
  * Save a segment register away:
  */
 #define savesegment(seg, value)				\
-	asm("mov %%" #seg ",%0":"=3Dr" (value) : : "memory")
+	asm("movl %%" #seg ",%k0" : "=3Dr" (value) : : "memory")
=20
 #endif /* !__ASSEMBLER__ */
 #endif /* __KERNEL__ */

