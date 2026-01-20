Return-Path: <linux-tip-commits+bounces-8079-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLznLjZucGkVXwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8079-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 07:12:06 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 314EB51EAD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 07:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7AC188A5C4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jan 2026 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BA83A89CF;
	Tue, 20 Jan 2026 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BnWgr3Ef"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5FF40B6CC;
	Tue, 20 Jan 2026 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912713; cv=none; b=YiKcWIw0BmPvxKpjlrYligxYnIispe81d7LOmfndnZ2S+kc5O51/PF79Uwu553FLbcamRNPLzaqy0mwDvjYs+p6yCKqo7Aqne+qeyKrPuc1Wp1tmg7E8z+zGtckyg/osgUJSaUJt5w9AR5pBzx46D4FhP6iAR3nRyTOgDhNsBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912713; c=relaxed/simple;
	bh=eDyPkTXYr00XGH9M33x6XFN1d6hs3v4gAv1PSVIB6i0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=B+gD3qGGvpXDwveczbF6KYKwwc59bpurZKTOuvO8ch74YYyt06zDva25bUNZCXZ8fwDLm5vSPBbFBiIlgBUOzHFIHA3NFBbXwZ/JQwsCzzzpQ0LyDNVuRwLFzj6i+JOWW4I1glJFEHDNxCXa0iBAXUoc9c4FSplcqEFZNvk0qVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BnWgr3Ef; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60KCc6Zc3666762
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 20 Jan 2026 04:38:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60KCc6Zc3666762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768912687;
	bh=c8VPZ++cHa1UezCV/GR820gnXP5ijg0/sZXLA8b2Q8U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BnWgr3EfGdDKQnG7WlpUf0KMnbBHZw+SI+sgeQbMJT7Z4/S5DKxiFpacSorPrJPqU
	 f6IAVFQIlpztqKnX5sdTi9010QwD/68acCd/erCGvXZhXcSl+zVsPOcbLePpTK5kO0
	 2gVN7FAyYabwqYB133LSALRw3xlqYe5dfFxorWm1jG0lcKiqITsQ8DAYZMUfq+ZXTh
	 AVjfs/6IAqgBpbtzuKtqOx1RSGnMScV/gl6cs2PIO2pY6BDMjLUNPk5d3mcNbQpH67
	 Pjp/1vFAv6Z6YlZipngwecqgJ59Z8mrVvAHDh6j6DH2C2TNF5HTPEOoYCSb0fMmRpY
	 NAqQ4rnvIklTw==
Date: Tue, 20 Jan 2026 04:38:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org,
        tip-bot2 for Uros Bizjak <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
CC: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mhklinux@outlook.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/cleanups=5D_x86/segment=3A_U?=
 =?US-ASCII?Q?se_MOVL_when_reading_segment_registers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <176891088183.510.8607818928752445249.tip-bot2@tip-bot2>
References: <20260105090422.6243-1-ubizjak@gmail.com> <176891088183.510.8607818928752445249.tip-bot2@tip-bot2>
Message-ID: <3A54B6DC-2462-41DA-8C34-D38CCD2A9A2B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.76 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2025122301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[zytor.com,none];
	DKIM_TRACE(0.00)[zytor.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,alien8.de,outlook.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-8079-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-tip-commits@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alien8.de:email,linutronix.de:email,outlook.com:email,zytor.com:email,zytor.com:dkim,zytor.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: 314EB51EAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On January 20, 2026 4:08:01 AM PST, tip-bot2 for Uros Bizjak <tip-bot2@linu=
tronix=2Ede> wrote:
>The following commit has been merged into the x86/cleanups branch of tip:
>
>Commit-ID:     53ed3d91a141f5c8b3bce45b0004fbbfefe77956
>Gitweb:        https://git=2Ekernel=2Eorg/tip/53ed3d91a141f5c8b3bce45b000=
4fbbfefe77956
>Author:        Uros Bizjak <ubizjak@gmail=2Ecom>
>AuthorDate:    Mon, 05 Jan 2026 10:02:32 +01:00
>Committer:     Borislav Petkov (AMD) <bp@alien8=2Ede>
>CommitterDate: Tue, 20 Jan 2026 12:34:58 +01:00
>
>x86/segment: Use MOVL when reading segment registers
>
>Use MOVL when reading segment registers to avoid 0x66 operand-size overri=
de
>insn prefix=2E The segment value is always 16-bit and gets zero-extended =
to the
>full 32-bit size=2E
>
>Example:
>
>  4e4:       66 8c c0                mov    %es,%ax
>  4e7:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
>
>  4e4:       8c c0                   mov    %es,%eax
>  4e6:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
>
>Also, use the %k0 modifier which generates the SImode (signed integer)
>register name for the target register=2E
>
>  [ bp: Extend and clarify commit message=2E ]
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>Tested-by: Michael Kelley <mhklinux@outlook=2Ecom>
>Link: https://patch=2Emsgid=2Elink/20260105090422=2E6243-1-ubizjak@gmail=
=2Ecom
>---
> arch/x86/include/asm/segment=2Eh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/segment=2Eh b/arch/x86/include/asm/segm=
ent=2Eh
>index f59ae71=2E=2E9f5be2b 100644
>--- a/arch/x86/include/asm/segment=2Eh
>+++ b/arch/x86/include/asm/segment=2Eh
>@@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned short va=
lue)
>  * Save a segment register away:
>  */
> #define savesegment(seg, value)				\
>-	asm("mov %%" #seg ",%0":"=3Dr" (value) : : "memory")
>+	asm("movl %%" #seg ",%k0" : "=3Dr" (value) : : "memory")
>=20
> #endif /* !__ASSEMBLER__ */
> #endif /* __KERNEL__ */
>

Incidentally, why aren't we using =3Drm here? Segment moves support memory=
 operands=2E

