Return-Path: <linux-tip-commits+bounces-8083-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FZEOdjBcGmKZgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8083-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 13:08:56 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E075685C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 13:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BDBE9A200F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40811413249;
	Wed, 21 Jan 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkSF6P0o"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780E40F8D2
	for <linux-tip-commits@vger.kernel.org>; Wed, 21 Jan 2026 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996172; cv=pass; b=HNePjzre74lbCeWoIFGyIh+G5oLjXPW2c1b5H4HwQIEtwbDSKV09EKPjAJPmaaYFfQ2ApWn8ANepRlH2XEW6spDcXWX7UiprpeTKbXNEsbQUh7igrD/O1cn8ZWwMQin3bBCiVtSVJ6T6+ihAXQrhRq3/ZJCWC/J6uTfVlIGTBBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996172; c=relaxed/simple;
	bh=qYzhnXCI6Om9Z0yQd0b83A17D0t5AAQrmpiuIMqwL5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNw+Ad6TqV81Kx1BkAqVj3DN+47++iLSkvw47C6NZ4kZwlgMOD7skpvOlCLwsP8t+7lBTbczsGvnMpcpbUELPFzVfXycUzJMdRqwtW4gUVSBd7ptLiZtHi3y9+9yZhU2DipHaSwh2NJ2L7fwqGxpqGVw5BaP4sUfSa4VDr2J3V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkSF6P0o; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9371f6f2813so1825939241.0
        for <linux-tip-commits@vger.kernel.org>; Wed, 21 Jan 2026 03:49:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768996168; cv=none;
        d=google.com; s=arc-20240605;
        b=ad8jn4ZdUyibirp47ZB4ARGLQwKUU0si7B4VMCwKlJ+ORkcnFXK6G4VgjiwAhwny1v
         tCSJ9KVaXudBbm0JoYP6fOfJuzG/YrKwGzqDYwWcA1DJCHndl5kAhjlzWtwqPO2xRbBy
         OcW3C259gdRTPcZWEZEoLLlm6n3tTzsofuPzpQb/8vuLDb/WgQdUTzHGqx0q6wHg1iR4
         gFkQu8Ac5etejE40wsabO9LWZK926O3ozb7WUEC5zE8TE5a/BvUdBDoH/+SxG/J1S79E
         azh/7lFu0/a/H5/PvpWekjT9aOxW/d6GrzGHMLPfwQqhO/PR4KVHT2OX6FQUQG0vTsw8
         BiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NE2RTsBwR9MdO+M1srlbkUt9zDc1bzMNiIy2ReoW9Ms=;
        fh=a5Q6UqYLjy+6dl7YprwX0sOfZjE/uFeJfpAEPEEt81c=;
        b=kL9aDI0R6WgyDVO3HOHm5pQ5QHl6zhQsuDaOFUGroVCfQ04wyb/0TsreiP17aeXs7g
         1kK96wZNMthyImojYIy1qrIFrie6rMH3FBHzzIcTcEv8X2JGI6NYEckl6utdn1/3ibrG
         0Vo1GTmXofY1p6uRL7bpbD9D34nFpsmKqDPepysY7by1FXgE3PTyOU931sLvkmhpfFxw
         JyP08vGpaUmoGbeOMSCDVCeJ3eGcdDZH1k6tUNfz39PBOW1d2ippYJlY5n5ThttReFhH
         p7ztI6WNskOIyVR8Z1aPzrKTvkB8klKrZftjfAIhH2YGR8ZFzbVKu9Zk6BOOgX8V1va5
         Konw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768996168; x=1769600968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE2RTsBwR9MdO+M1srlbkUt9zDc1bzMNiIy2ReoW9Ms=;
        b=HkSF6P0o0KxVJCJTIK4oqv9/kMNZBsIrrNPuZ72C85ac+frwiADUv34JYA3l6yF2Pg
         J/d8QDbTKIegIc51bffFnUsveHBkd1xI84nkQQTIt2QxsHMWeHRGw0sCbBsc8SlvhdQs
         m8PypRth4m2ErVY5xh99lgGWYSiHTp5STbhbeY0+HMmmcvQaDT/oZAAongbzIZJN7k2o
         e3r11iEYOjYu7y2Q34LbGbRgr60ihxKJh07uOoYtw9JF83gc0jATwWcrX6lorn3l4E9a
         PFyV7m4U9z4AaWbwv6hNq/aaDff7GEMWVyTfGIXai0VPZKNYU469HJyrq2CqOGg8AFt+
         teJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768996168; x=1769600968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NE2RTsBwR9MdO+M1srlbkUt9zDc1bzMNiIy2ReoW9Ms=;
        b=OhxQq8kfE8sfR8gOTT6yWXSqu1NTVNLBPb2WW3jC6qMx42CSbOGvP0Lfg0Hz2jlrRt
         HDzgts0L+oSI0AduGVjrY8V5fYH+wRkdBb3sQWJSkwnXllEpp4Rbjlo76th2EGeNiaBK
         dNlKBwZ7gtjbJI4iQ0XK76aSrTBSP2zcwOb92vwwFqBlZ6UA0semPxu47oNOAdTLxB8x
         QDGZV8dcVQ0y6qWwPJYMlwJWN5XK0qD2PlrJzsHlmTscBreCseRuD6adRjXC0l8aXRsL
         NAj4SpEB+Em1o3KN5i2i31lheyDBUoRjSvYnxN6p5h+9wF2dYW4/gPZJRjo64pyt4rki
         dzQA==
X-Forwarded-Encrypted: i=1; AJvYcCWVGDJ6MWuAncqLttYVhp4p+vVWXH4j6F2licflGS2HdHRAhP2+c8D3UUGC7llfYvOf8H7FFOL5xsoIqt5lh0p5rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcP9KYCxYnOThom/IxpG+azrE1d4Z3yOKVQhVGzToQ7Z9RCbe
	9OBdtH4Q5XcqoHvMCUWDb1DAL0qF9y8pjojIinPWTyU8V2TgwXLOYw5SeVswDC2fl9t3YYXufSe
	nwfrmxZZEjLzqATSpcUk6f0waaT2w8g==
X-Gm-Gg: AZuq6aLcIyiDN6MdW6pMFWtdRBovX75EEiig+iWoyX1Y+agjrCZXIAjadSWoDV/eA6E
	0Bb15HPyKvXlfMHm6ZCUTMFfxTNveLrySSZPot//AvHzKOuBkibXEoScjcFLZBJhQ+Giyk8PNAQ
	JAiR6pD3g2Hom2GP4674FiY8ZBrBppd/HxXyavE9+dynDqYtr+5pFiP38SEPhovrs2RuUDFSCoR
	Qs9SeCiooeEJtcKHgoBRMSAkbDuKTOV50sLQqvS/VPYlm3DegGbwvnG/izA7GtFFe3kileWmzn7
	3ETXmjzu2A==
X-Received: by 2002:a05:6102:5492:b0:5ee:a12d:55b7 with SMTP id
 ada2fe7eead31-5f1a719df13mr5182600137.29.1768996167768; Wed, 21 Jan 2026
 03:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105090422.6243-1-ubizjak@gmail.com> <176891088183.510.8607818928752445249.tip-bot2@tip-bot2>
 <3A54B6DC-2462-41DA-8C34-D38CCD2A9A2B@zytor.com>
In-Reply-To: <3A54B6DC-2462-41DA-8C34-D38CCD2A9A2B@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 21 Jan 2026 06:49:16 -0500
X-Gm-Features: AZwV_QjFmdVLOmxMU-LP3y7gXGJUW7SYMoFoU0fFfKdCZORlbTEXKclkQYXPUaU
Message-ID: <CAMzpN2gsMdry_v1BKk=e2x1A2Z3W+caaiFzGm7mkotr4SihrYA@mail.gmail.com>
Subject: Re: [tip: x86/cleanups] x86/segment: Use MOVL when reading segment registers
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, 
	tip-bot2 for Uros Bizjak <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, 
	Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Michael Kelley <mhklinux@outlook.com>, 
	x86@kernel.org
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
	TAGGED_FROM(0.00)[bounces-8083-lists,linux-tip-commits=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,gmail.com,alien8.de,outlook.com,kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[brgerst@gmail.com,linux-tip-commits@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,zytor.com:email,outlook.com:email,mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alien8.de:email,linutronix.de:email]
X-Rspamd-Queue-Id: 53E075685C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 2:29=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
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

You would have to be really careful to only use short (16-bit)
variables, because it will not zero-extend with a memory operand.

