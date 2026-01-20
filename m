Return-Path: <linux-tip-commits+bounces-8080-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMMeKX40cGkSXAAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8080-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 03:05:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F844F7C5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 03:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA48572481A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jan 2026 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40403425CFE;
	Tue, 20 Jan 2026 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb5lvVT7"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571383EF0A8
	for <linux-tip-commits@vger.kernel.org>; Tue, 20 Jan 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916858; cv=pass; b=ERgIVWbk5v0VBvZ17Vq2f4eCkyXczvL653WN08XV3f7zBy5IpHYFU8sF6yt55E9r3/4C9KAozUZgNuY7JWYEpSU2LyRO2o+smKt6Dnfsx4LLvF7TkqNYM1xsf8CPAZyb/V+YgCl3FztFAt42Yl/bUbO9eGFOj/0ujLSRevCRgUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916858; c=relaxed/simple;
	bh=Em4rfdylJAyQY3ynxddFP0QAE3LrKuprwDGZi4oouw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/XTBkElHA0H+dQhNoeQ4RgA0lYT6ZZguEHMc4b0kqyKL9wrFJKFbuGWDDUOdS7tcWnNanPdnGEF8CAXDse0Tpnp7d4dgFk0G6gQ9sdGG7v5hZvrJjK1bH2zElP3GF7iMJp0leaQX01wF0Hqpqf7SxlIMGkuk9AeCWi13oYrCJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb5lvVT7; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37fd6e91990so53530551fa.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 20 Jan 2026 05:47:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768916854; cv=none;
        d=google.com; s=arc-20240605;
        b=FLB5x/UXwDq9+qYMDGrzCydtr7BM9QaXCKK5VCxpeSqfr/k5KJ/sNRq+VimiArmyJS
         YfozWn0MBmoObSVdsDyIcc+HbIkq7BURYdqCWabiqvYrTfrK8ZXj/DwXbhuBAAWMdGw0
         cg7Cxb2U0UTo84l7XgPRst5i0Q89z9qNCMqv+gqy+ZZ5pLBUQorhkCL5DZIQbm5lGRVc
         YrH0I86502Z/0bI+mMJAGKHrdpOLA3IPwHSC+/EJh+MM8EDOYS+1VTDYIduZb8nMyb1m
         x+3hbukmHeObUDIlClZ08H3/wunz/RsKAWm+t91sX4++C5VQLoy9zOX9mFJApOZKghfy
         vcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YASblyJdvwsvYhEZCB7QZ8/yyLj4aFAgfVTGfyM8vJE=;
        fh=wnuqBj1qj7ihKf5UTLkKH8FS45K7yPnc6NQ5Wpf+Hns=;
        b=C2ZgAOIpliV/eBW5y5CVKlaTmibbM6bhFuvxpWwroJOqi3zJ3++x8oEoHM7vvdfbWW
         Tt8jxWxpJeNI2zPfw5X0vY3TbuGDLrpySft+hkafF1ebETlyw99LCFTKzaXe7Kavrn2h
         9j6gNYsuSOwV9g6j3/1EI8wTLJINMBo9u4C7WwbSxdVcGWO8Ng70+vzOTza9wNDIWhu9
         7rdx+OLFXZnNtfqtH1R9QKdlbVPzkhTyk7mfHC7iMMm6vWC2CknKaJFliplBxKksUxrA
         MlesK6N/xBcghh4VyhA1weQghUlE0RfOr7JvDc4HghYVgAE8Rq+2fsF3lhkr6Q1pn9L8
         tMEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768916854; x=1769521654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YASblyJdvwsvYhEZCB7QZ8/yyLj4aFAgfVTGfyM8vJE=;
        b=hb5lvVT7DwQclr13zvcJUPN+Qxxp+1FhGEdQ/68y81uloLcOt97ze//TaSadMVIXk7
         XurGE0UlIc6TOF9dMWWK2ELgy+8CDsSDKQl3WNhbqrrGjtpQOwSEIBTo9cmIg/R+HDH5
         zr3dhiB+FVfHujfvshFhixIdhVR6uND5vzwG73liXlQj9mQmXCFCBwU3/UtRRf49GHHO
         g9bsdk0n6ARUgAfsxhrTk2tfzoNTVh/ki3x9IxVdBxnfHYJ4s96pScq/bO48ieUGZZ+T
         OJ5imM3T7Dus2sWroPUkus1x7eqsZsqdCBrfsBLFU2ax3Y/q03nh7v+BF8rnl5CHZMjS
         4vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916854; x=1769521654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YASblyJdvwsvYhEZCB7QZ8/yyLj4aFAgfVTGfyM8vJE=;
        b=PaQP2IK8niiwr8xmFPJFSsvW98LlEN0sKgB7pDjPJmksFHEwM2qNrSuYAbzko8nMHc
         NgNCyRXtzRhgdXZsCk54pNB+acRjxKBS5ArwGKiTztn3ST7WyA7D75z6O9eBvkTBxC4B
         LhH4txZdVez1E1DX2MxVZ4y4x07ZXJGbXAocTChqPcS0GrSMM9shm2Sto4i/StrCjxn4
         99COTEGMFjl+jOQbVaaarob3ednuUk+LGmLkE4tbuF+EY9Qx3Xx+AltBvIJKbGBa4hHW
         z81+/3F1ghI5hjqD33x5QjKUtPRmOhiKMZyuLIdzlwkvCx0CfI8/VH/hPm7ve3DOcUwm
         Kw6w==
X-Forwarded-Encrypted: i=1; AJvYcCXJ9WEhwLCr0ld1If+Phj4EzzAcwH6VdURpf2UJqxDEOd8j06kvFQodPj+CrefI5QEGEWLns/J9D8x+tL8iNqFysA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9gVTgRz8rb7nAdZGVwgbsnecnsiZ4bKxLqTutRMEcs8zqbTH
	y3e72y/Bvya/UL58RQKcGUpdYembCYKZiY25sfxM4o3n/Vs0/sUxvczrJpbQio84t7NSLJMc93N
	wZnTvYxGbVDF1rqii1IzrfEW/moxhUBw=
X-Gm-Gg: AZuq6aLz/4faCzOswQkDrGUMKBYNQixiVLzl0PoLOEX+xz/THrxSBcIM68rmv1iDOx+
	uspeIdftUqt0o+cUL/+apzfT2YoxP37lHrJcEPY/hiNFxPcmOTcFHWsAnzbRiTnZKGZhJnXiL0C
	qmjJ/Q8rOwv53Or6s76XtyKvPGh8JxjfSjMeKd+GXO2sUsT0SUb40pj7eD361/9IuLguQoj0KbE
	CWYFV67bOYlvlNlOzm0Efb9BkLTwbaX3Ts9rlTEr37CQBi9wxkRuZMO3Iek3K77GvUtiv8c5GRU
	PH4tGI42YwXiVpWJ6TpKq/jL8NUIzqmEi+Ma8Q==
X-Received: by 2002:a05:651c:a0a:b0:37f:a216:e473 with SMTP id
 38308e7fff4ca-38386584ffemr46138881fa.0.1768916854109; Tue, 20 Jan 2026
 05:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105090422.6243-1-ubizjak@gmail.com> <176891088183.510.8607818928752445249.tip-bot2@tip-bot2>
 <3A54B6DC-2462-41DA-8C34-D38CCD2A9A2B@zytor.com>
In-Reply-To: <3A54B6DC-2462-41DA-8C34-D38CCD2A9A2B@zytor.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 20 Jan 2026 14:47:22 +0100
X-Gm-Features: AZwV_Qjdc50Mt-sJyxytOmXoPx7r3rFIxA7DG__CnW3pVpBemCySnNvmezotAGA
Message-ID: <CAFULd4Z8PG88oNvzUQ_K0MV+wjsrGK=b=gPzdgkTGm3ceo9gdg@mail.gmail.com>
Subject: Re: [tip: x86/cleanups] x86/segment: Use MOVL when reading segment registers
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, 
	tip-bot2 for Uros Bizjak <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Michael Kelley <mhklinux@outlook.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8080-lists,linux-tip-commits=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,alien8.de,outlook.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-tip-commits@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,outlook.com:email,mail.gmail.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: D2F844F7C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 1:38=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On January 20, 2026 4:08:01 AM PST, tip-bot2 for Uros Bizjak <tip-bot2@li=
nutronix.de> wrote:
> >The following commit has been merged into the x86/cleanups branch of tip=
:
> >
> >Commit-ID:     53ed3d91a141f5c8b3bce45b0004fbbfefe77956
> >Gitweb:        https://git.kernel.org/tip/53ed3d91a141f5c8b3bce45b0004fb=
bfefe77956
> >Author:        Uros Bizjak <ubizjak@gmail.com>
> >AuthorDate:    Mon, 05 Jan 2026 10:02:32 +01:00
> >Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> >CommitterDate: Tue, 20 Jan 2026 12:34:58 +01:00
> >
> >x86/segment: Use MOVL when reading segment registers
> >
> >Use MOVL when reading segment registers to avoid 0x66 operand-size overr=
ide
> >insn prefix. The segment value is always 16-bit and gets zero-extended t=
o the
> >full 32-bit size.
> >
> >Example:
> >
> >  4e4:       66 8c c0                mov    %es,%ax
> >  4e7:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
> >
> >  4e4:       8c c0                   mov    %es,%eax
> >  4e6:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
> >
> >Also, use the %k0 modifier which generates the SImode (signed integer)
> >register name for the target register.
> >
> >  [ bp: Extend and clarify commit message. ]
> >
> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> >Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> >Tested-by: Michael Kelley <mhklinux@outlook.com>
> >Link: https://patch.msgid.link/20260105090422.6243-1-ubizjak@gmail.com
> >---
> > arch/x86/include/asm/segment.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segme=
nt.h
> >index f59ae71..9f5be2b 100644
> >--- a/arch/x86/include/asm/segment.h
> >+++ b/arch/x86/include/asm/segment.h
> >@@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned short v=
alue)
> >  * Save a segment register away:
> >  */
> > #define savesegment(seg, value)                               \
> >-      asm("mov %%" #seg ",%0":"=3Dr" (value) : : "memory")
> >+      asm("movl %%" #seg ",%k0" : "=3Dr" (value) : : "memory")
> >
> > #endif /* !__ASSEMBLER__ */
> > #endif /* __KERNEL__ */
> >
>
> Incidentally, why aren't we using =3Drm here? Segment moves support memor=
y operands.

I have tried it with "=3Drm", and there were no cases when memory output
applies. Also, it would need to use  ASM_OUTPUT_RM to handle clang
issues with memory output alternatives.

Uros.

