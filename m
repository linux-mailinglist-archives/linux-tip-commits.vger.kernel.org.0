Return-Path: <linux-tip-commits+bounces-8081-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ51MqIWcGlyUwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8081-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 00:58:26 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE164E36B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 00:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E18E23ED9E2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jan 2026 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A240A43C04A;
	Tue, 20 Jan 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl75fOuR"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9243635F
	for <linux-tip-commits@vger.kernel.org>; Tue, 20 Jan 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917796; cv=pass; b=OJ2YCBNdusJsHDHaBkazQH9GUB75Ersai+weZrPP9tLHqxdXr5L9p8+4/S71mNb7zAxtpXxMlIZqBFY4xQQMMpoWIvjLISbVNGPWgI8oA9dNxy0r+CWs2ljdMRVy8JeztOyLo9pb2KWxqQWmJzB7cRnw5tAuFGl4ttlRfB7ADQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917796; c=relaxed/simple;
	bh=JahNnD+2/4ecxTW7P+pOfDNlIX1M8OWskqmPPRsahSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh4QOdB21ixUHmOvdfHz6QFRjF5wnYb28YSwG1zhFNoaVicIatufgJzHMOQdhgGNY5dlYnfPmE+b5UnNN/quN+Se2ZIZC6kUqtrFmFsbBO699Qb5422Yt9f0aL8eORcngxXUTNP705TGXIwtwpkR3nBI/iQDtne6YM9ABd5NuLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yl75fOuR; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-383247376a4so47143571fa.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 20 Jan 2026 06:03:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768917792; cv=none;
        d=google.com; s=arc-20240605;
        b=e2viV2YylgnorO+oOxhFGzFNgqpVqEGM8SS00ivSdu8dMNmmyv76EQJJbXevKzH8Ti
         uISNf4XK37oPtjMLNmcafMp+gOAG2QOKqiwqyIQkdSSoNRHHyfrERBd0Wng9F0UaZt72
         ZjnHaq89QbiitMpwK4MWQTnmWSyhYXB8TirWCAcMQ4MCJFXeDn4+kSSBdNkPHkQRi8lh
         f5RaUd6o+fbuSkcN35ixY5qKFIuVV04qg2bFN24/KLm0q89Jepp/vMDjLqWYwmpGFvZd
         nAFbwESWMZK+RXpfoT0gT9a3aeiRzkgAMW598sPJ9iLYKx7WEiq9f256O1mlfvfs7jOZ
         7I6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ADkzUHtuO/vCn8+gSsN/JWvIgt4gmIA5VnUt9FG4nxY=;
        fh=D2ZEPL82gtgRsl2Ay54wQfunnR5a6joCCvG9yBIF+S4=;
        b=iDvnQeoYnj33ymkEf/Q/EQzwL+9rTrKOwYfXiRu08RdDA3RYUnilBR6JkMtOv0L7FH
         G8WqVz7eJ2nvpcBsH4OuOIno+b1/NlKNy344yvtESpYu2tnTJes0SPXspJNbMkK12/9e
         vcShvgUtgSFKUw38x3d7FGt21XWUqw7rQpKFVs6+BYfNOW+lBMWUN9ksIdOVFczKGJ9k
         EK3+sz1JyDRtsvAOp1XfHVEHmv00WLzbBr+4KCKAn2BT4mQe0M9wVq2QGHpLfuDJe6w3
         Dg8KG6ZR3ndFCcFrXAIhQZREp05A1c9JY0PV8U0qLPTRtVvIh+I2GQ6us9W0Kf4DTzdr
         hlrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768917792; x=1769522592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADkzUHtuO/vCn8+gSsN/JWvIgt4gmIA5VnUt9FG4nxY=;
        b=Yl75fOuRKQuU7K6Vazxow60LqcOxqk8T6qjpp359W3KQXABqx9nnTkPnmsA1X27AF8
         uCtTq54yUxF1/9nnbJ1xBlmT1QncYjMUVicTtxoZmFTlS277McP2naru/iW7H7Ydxddr
         tDuR9CUYCNsjNP1kvyoZT7cMfZuLC6lQc7Lfbwr1gI6YDM1uevV7dgUlyzYBUBNS7HIH
         HFgvUmg2Htv+sUz5rDE7GSb+EJMBMIs0sMqeaQgLOW9f/7CsBy8/VXZHQPDbVTr9td8U
         lQomawWReAQM7uztWEOt2lH4KDJNorPzA30JscVKk6AD2XPFGiLdjvAFKVDxOG02gxSR
         JrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917792; x=1769522592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ADkzUHtuO/vCn8+gSsN/JWvIgt4gmIA5VnUt9FG4nxY=;
        b=O29Fyi8ZQU1Ga5E7wVUj9S96flTpQuSEsjGGRWNHoGZVNVHce6rTj8KYL/esqUQKIe
         IJNxFrAx/owFK00dn5L194SBUgr/gopPESdKAqEoNVlNXNwzu8Kno0eKLjNNIEeYqUil
         HsIdxYoQsJwH35VmiDtb/RpSlH3mFSP/K3w4jXpC7AmD7Lt0WJKCf/hLPXVQpoqXTcCU
         9QyF1Hh8CqbXpDA/r2NTUO6DSJYVpJ6U1ToJgKovTKw7ThwuR4J8oP70vofO+6ansjjj
         oKXOslGo50Y2ivdBuWopaHsfm6LncbTSyu2cd5voCSRjv3WQTxI0VZTTIPh2B9zokIeq
         owzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/IKXiXpIuo/VZYTYTFLBKo07wYASLcxBXP6X9qhp5a13zUhxtue1FiiUa2o0WRPeOfIqNakOzDHKZRIiyi6uAHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZo9LewEfTmhpfePk+vjM+Q8dPLA2Tkfk+ZUKwy90TQQj8tJK
	w8yJDkj5FIFG58fT9TkozDUlDOL61qPh3xjc+xKMQit0XhzqBVux6AcFF02JoTM+kQIHlLOs9n5
	yRtRnb2D/kwjZcRuDA9S76OFgONbGRfA=
X-Gm-Gg: AZuq6aK332znEqRfamVMsPNIdnAESFfAV/KSjFQc6QJC4hz+Rli806UkEhKH+mgdqBH
	68iogjWafQtGhN7rZ6LGeISh2c13uoPz0GiE2Vo6EaA1B5vyIaeEZRp0sDeKvzmgUIuRk4o9iCC
	BFA9Xckuw4msEmHYJV1hVt3Moe5D8Q8chymTbaFPz+5gIyFJF4rnCcwRd58iWPFJglYqzkS0zge
	SjxwUkXdEW5J6C6AJBVSdLiSSzOMYhu2HDx6ZHd2YVL8AekxDy/GuqR6WGC1/R6biKp9uyBbk2K
	WFQ6Gsa2X1z+1b/PLBMN7ClY7qujgBp+kBQZuA==
X-Received: by 2002:a05:6512:63c7:10b0:59b:b020:a71c with SMTP id
 2adb3069b0e04-59bb020a733mr3213757e87.13.1768917791437; Tue, 20 Jan 2026
 06:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105090422.6243-1-ubizjak@gmail.com> <176891088183.510.8607818928752445249.tip-bot2@tip-bot2>
 <3A54B6DC-2462-41DA-8C34-D38CCD2A9A2B@zytor.com> <CAFULd4Z8PG88oNvzUQ_K0MV+wjsrGK=b=gPzdgkTGm3ceo9gdg@mail.gmail.com>
In-Reply-To: <CAFULd4Z8PG88oNvzUQ_K0MV+wjsrGK=b=gPzdgkTGm3ceo9gdg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 20 Jan 2026 15:02:59 +0100
X-Gm-Features: AZwV_QiNYJKWN3m86GfkNQJiJZbKj1Hxwa6GB-pvz7lyonQf8EIFsyeE7L-Atbw
Message-ID: <CAFULd4aAWAm8SxZQQZXTDB0ERG5AcOt1SD1-cUy4LudKCqKqoQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-8081-lists,linux-tip-commits=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,zytor.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,outlook.com:email,linutronix.de:email]
X-Rspamd-Queue-Id: 6FE164E36B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 2:47=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Tue, Jan 20, 2026 at 1:38=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wr=
ote:
> >
> > On January 20, 2026 4:08:01 AM PST, tip-bot2 for Uros Bizjak <tip-bot2@=
linutronix.de> wrote:
> > >The following commit has been merged into the x86/cleanups branch of t=
ip:
> > >
> > >Commit-ID:     53ed3d91a141f5c8b3bce45b0004fbbfefe77956
> > >Gitweb:        https://git.kernel.org/tip/53ed3d91a141f5c8b3bce45b0004=
fbbfefe77956
> > >Author:        Uros Bizjak <ubizjak@gmail.com>
> > >AuthorDate:    Mon, 05 Jan 2026 10:02:32 +01:00
> > >Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > >CommitterDate: Tue, 20 Jan 2026 12:34:58 +01:00
> > >
> > >x86/segment: Use MOVL when reading segment registers
> > >
> > >Use MOVL when reading segment registers to avoid 0x66 operand-size ove=
rride
> > >insn prefix. The segment value is always 16-bit and gets zero-extended=
 to the
> > >full 32-bit size.
> > >
> > >Example:
> > >
> > >  4e4:       66 8c c0                mov    %es,%ax
> > >  4e7:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
> > >
> > >  4e4:       8c c0                   mov    %es,%eax
> > >  4e6:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
> > >
> > >Also, use the %k0 modifier which generates the SImode (signed integer)
> > >register name for the target register.
> > >
> > >  [ bp: Extend and clarify commit message. ]
> > >
> > >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > >Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > >Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > >Tested-by: Michael Kelley <mhklinux@outlook.com>
> > >Link: https://patch.msgid.link/20260105090422.6243-1-ubizjak@gmail.com
> > >---
> > > arch/x86/include/asm/segment.h | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/seg=
ment.h
> > >index f59ae71..9f5be2b 100644
> > >--- a/arch/x86/include/asm/segment.h
> > >+++ b/arch/x86/include/asm/segment.h
> > >@@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned short=
 value)
> > >  * Save a segment register away:
> > >  */
> > > #define savesegment(seg, value)                               \
> > >-      asm("mov %%" #seg ",%0":"=3Dr" (value) : : "memory")
> > >+      asm("movl %%" #seg ",%k0" : "=3Dr" (value) : : "memory")
> > >
> > > #endif /* !__ASSEMBLER__ */
> > > #endif /* __KERNEL__ */
> > >
> >
> > Incidentally, why aren't we using =3Drm here? Segment moves support mem=
ory operands.
>
> I have tried it with "=3Drm", and there were no cases when memory output
> applies. Also, it would need to use  ASM_OUTPUT_RM to handle clang
> issues with memory output alternatives.

Also, savesegment() is defined as a macro, so e.g.:

--cut here--
#define savesegment(seg, value)                \
    asm("mov %%" #seg ",%0":"=3Drm" (value) : : "memory")

char c;

void foo (void)
{
  savesegment (gs, c);
}
--cut here--

would result in a wrong code, where word sized 16-bit value is moved
to the location of "c".

Uros.

