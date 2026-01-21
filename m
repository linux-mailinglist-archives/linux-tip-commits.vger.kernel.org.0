Return-Path: <linux-tip-commits+bounces-8089-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNUnJyQycWlQfQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8089-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 21:08:04 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 443155CD63
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 21:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C94F4360850
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BDA364E9D;
	Wed, 21 Jan 2026 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBftqzqG"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87735F8BD
	for <linux-tip-commits@vger.kernel.org>; Wed, 21 Jan 2026 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021746; cv=none; b=uBeX/AiOauaokodQLADvCA3eSSLJWOaBBawCoG0SZl7K4CGUTLRKLyQy1YrwxwNvBs9v4QyGOdiagFioeEpNEBzoIPHbQGqhAI9YnWaGtYv4w75JdiEKtWkOQAv2jJo5d7/baVnLIdYLajtHGIQmBL72Sp/0DgvBu8kefiWEIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021746; c=relaxed/simple;
	bh=rIRRLkp7MPVbIyZC4f++n0+pkFOpc3J30VleyO8KIGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc7a7+DwylvvgjejxvZhIaOt9wlo/gZG99TSGce9UdIxUdEni6hSdXOwXCVxD/K7SjuhL7YG00sJKIp+yq3MoCRwylQCQcG1TSpX5Xk8fj45Rv28N0lBZNu12Fti7mnQC/NI93wDbYBydgSfPGltF56NAS5WdzNyNBziPSInk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBftqzqG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso1515885e9.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 21 Jan 2026 10:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769021743; x=1769626543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhUOv7KX00GMoXigAayvyx8FpUHGiBwLODsURrtT484=;
        b=YBftqzqGe1b7Df3APzmxUVRCC/I/Gw0ObtGkn9cpu8i4LIZax8z6VOTVtDvk4Mg4Er
         z0rgR4Gul1+akNQspmN9agwBBlGtbP1+8xfCXDoWGnj60pPqOUkw+eOzDqubZ2Ng1rjI
         i5JEZpBadTXy+dOPVgEAgjvXTYx99Vl+DlGS5wGQ0ih1X1OwixR0Ohl9RVukjBHTk244
         LrL9ZALNomOXVxun6emB4eXnP+txTuLKwlBSrhinjjOcWxheFQZU9OgdHUxYKRoNDvg0
         FVIFJz84bPZM6/gs0je6WvNxh3xT9CpLsPnj3Olb/ihbK6i082xiCi1OcKT9cXehykaw
         tDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769021743; x=1769626543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhUOv7KX00GMoXigAayvyx8FpUHGiBwLODsURrtT484=;
        b=rd7IhdYgu4FnK68cknuPHtShuVHG/jfgpuu6I5t8AOWu2KhS+tjq1OthUksFjOdVHL
         Gqgpg5mzt3MgVqU2AaDXhy74kH3YkJDIQRJKtTXho8tdxfrl+zI9zO58+QSh6LZsGnDv
         zb/8GBrtIfkCszadRso48Ubo5cWdRLuEfM/DLES307ARi0QdOiLViB3Hp+hv9I6qWaDh
         gIQf79J9k1luReKupAeDRmlNAf2qg4T5Tp1ocWmiUnGCQ12+u8L15+FRBqHz0rUN7RUm
         RwxGRTmnhiHhJ6OH3W83UtNW6W2VfsgWFBY8fqSGx70fjt3GWIMLdmIOm/hiJBHTiYcH
         sD2g==
X-Forwarded-Encrypted: i=1; AJvYcCVy94CFS2JWEGGyTW5UwK7/Ttx1VRoD7rt6OaYH78QkJlwBNrAayE1l0441a8o5VImNFgFi36ayH7JZIrGPND+PGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCE+WTucPgEqS47gU3kXNg+3erabJzk9/WqrjdCzfcneLGlAp
	5bSzLejM0RwskuHfX4rGotX7mlBoGvtXBSg1la24q3Yzwv2K8czOk505
X-Gm-Gg: AZuq6aL6zAHA2G2qUdnBQt8UX7ZFwLbuN/CMitgE5XIELdZ830uwoypEPMSbzpp7CI0
	HbQ+GG2hxAWQmfZ3DoGMMG+SCswTJRqtCvzU/mZGDTE3jqRyLWu3UqDXBfWVURvll/jIOYFtgwk
	uiAEeW96Pl7rqIsAjTLTiKU/W3Ze4pFsWH9CCOC2ftw2o/EqjNqzLPIa35bC+O1crTK2hNyvneq
	OsvX5lQVi8bgVRtC+SJySEy3ij8PUTTNoudRPsmJ173Kfy9Aqwh6b3vJVV98g2tyYuHNj5JrwMt
	NTZGZLV8YOtH5M5MnZbWTiIBd5evVewHBz0Q9WjW7nj0x33QHdW7SPqZ6ZqLl8dlfnmuk110BLv
	uP+sw1iSRgK5X8aFLosC6/7GBJzKWxqakM+urFsgqR7U6/aRVwSiV+JBCwQMwUNUhJFsueNl1ri
	3ekDHvipDSUh/NXc3KVlThKSpzOGgnFkGfp19oDcpG3jzj+8+RAWiT4Tyhrd6srHg=
X-Received: by 2002:a05:600c:8b67:b0:47d:3ffb:16c9 with SMTP id 5b1f17b1804b1-4801e342091mr208550085e9.23.1769021742295;
        Wed, 21 Jan 2026 10:55:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804705b277sm7496065e9.12.2026.01.21.10.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:55:42 -0800 (PST)
Date: Wed, 21 Jan 2026 18:55:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, tip-bot2 for Uros Bizjak
 <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Michael Kelley <mhklinux@outlook.com>,
 x86@kernel.org
Subject: Re: [tip: x86/cleanups] x86/segment: Use MOVL when reading segment
 registers
Message-ID: <20260121185540.020f7b72@pumpkin>
In-Reply-To: <CAFULd4b8hJpY-gAy4MPug1PjK4ME0M_jeBZ68XLjYuSERr7RKA@mail.gmail.com>
References: <20260105090422.6243-1-ubizjak@gmail.com>
	<176891088183.510.8607818928752445249.tip-bot2@tip-bot2>
	<3A54B6DC-2462-41DA-8C34-D38CCD2A9A2B@zytor.com>
	<CAMzpN2gsMdry_v1BKk=e2x1A2Z3W+caaiFzGm7mkotr4SihrYA@mail.gmail.com>
	<20260121140857.3544d19e@pumpkin>
	<CAFULd4b8hJpY-gAy4MPug1PjK4ME0M_jeBZ68XLjYuSERr7RKA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8089-lists,linux-tip-commits=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,zytor.com,vger.kernel.org,linutronix.de,alien8.de,outlook.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-tip-commits@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linutronix.de:email,alien8.de:email,outlook.com:email,msgid.link:url,zytor.com:email]
X-Rspamd-Queue-Id: 443155CD63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 17:16:53 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> On Wed, Jan 21, 2026 at 5:06=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Wed, 21 Jan 2026 06:49:16 -0500
> > Brian Gerst <brgerst@gmail.com> wrote:
> > =20
> > > On Wed, Jan 21, 2026 at 2:29=E2=80=AFAM H. Peter Anvin <hpa@zytor.com=
> wrote: =20
> > > >
> > > > On January 20, 2026 4:08:01 AM PST, tip-bot2 for Uros Bizjak <tip-b=
ot2@linutronix.de> wrote: =20
> > > > >The following commit has been merged into the x86/cleanups branch =
of tip:
> > > > >
> > > > >Commit-ID:     53ed3d91a141f5c8b3bce45b0004fbbfefe77956
> > > > >Gitweb:        https://git.kernel.org/tip/53ed3d91a141f5c8b3bce45b=
0004fbbfefe77956
> > > > >Author:        Uros Bizjak <ubizjak@gmail.com>
> > > > >AuthorDate:    Mon, 05 Jan 2026 10:02:32 +01:00
> > > > >Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > > > >CommitterDate: Tue, 20 Jan 2026 12:34:58 +01:00
> > > > >
> > > > >x86/segment: Use MOVL when reading segment registers
> > > > >
> > > > >Use MOVL when reading segment registers to avoid 0x66 operand-size=
 override
> > > > >insn prefix. The segment value is always 16-bit and gets zero-exte=
nded to the
> > > > >full 32-bit size.
> > > > >
> > > > >Example:
> > > > >
> > > > >  4e4:       66 8c c0                mov    %es,%ax
> > > > >  4e7:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
> > > > >
> > > > >  4e4:       8c c0                   mov    %es,%eax
> > > > >  4e6:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
> > > > >
> > > > >Also, use the %k0 modifier which generates the SImode (signed inte=
ger)
> > > > >register name for the target register.
> > > > >
> > > > >  [ bp: Extend and clarify commit message. ]
> > > > >
> > > > >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > > >Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > > > >Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > > > >Tested-by: Michael Kelley <mhklinux@outlook.com>
> > > > >Link: https://patch.msgid.link/20260105090422.6243-1-ubizjak@gmail=
.com
> > > > >---
> > > > > arch/x86/include/asm/segment.h | 2 +-
> > > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > >diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm=
/segment.h
> > > > >index f59ae71..9f5be2b 100644
> > > > >--- a/arch/x86/include/asm/segment.h
> > > > >+++ b/arch/x86/include/asm/segment.h
> > > > >@@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned s=
hort value)
> > > > >  * Save a segment register away:
> > > > >  */
> > > > > #define savesegment(seg, value)                               \
> > > > >-      asm("mov %%" #seg ",%0":"=3Dr" (value) : : "memory")
> > > > >+      asm("movl %%" #seg ",%k0" : "=3Dr" (value) : : "memory")
> > > > >
> > > > > #endif /* !__ASSEMBLER__ */
> > > > > #endif /* __KERNEL__ */
> > > > > =20
> > > >
> > > > Incidentally, why aren't we using =3Drm here? Segment moves support=
 memory operands. =20
> > >
> > > You would have to be really careful to only use short (16-bit)
> > > variables, because it will not zero-extend with a memory operand.
> > > =20
> >
> > It would be much safer to have something that returned the value
> > of the segment register (zero extended to 32 bits). =20
>=20
> movl from %seg to 32-bit register (as proposed in the patch)
> zero-extends the value all the way to word size (64-bits on x86_64).
> The proposed solution also handles memory operands, so:
>=20
> --cut here--
> unsigned int m;
>=20
> void foo(void)
> {
>   asm("mov %%gs,%k0" : "=3Dr"(m));
> }
> --cut here--
>=20
> compiles to optimal code:
>=20
> 0000000000000000 <foo>:
>   0:   8c e8                   mov    %gs,%eax
>   2:   89 05 00 00 00 00       mov    %eax,0x0(%rip)        # 8 <foo+0x8>
>                        4: R_X86_64_PC32        m-0x4
>   8:   c3                      ret
>=20
> Uros.

As does this version:

unsigned int m;

#define get_seg(seg) ({ \
    unsigned int _seg_val; \
    asm("mov %%" #seg ",%k0" : "=3Dr"(_seg_val)); \
    _seg_val; \
})

void bar(void)
{
    m =3D get_seg(gs);
}

bar:
        movl    %gs, %eax
        movl    %eax, m(%rip)
        retq

Without the hidden lvalue.

	David


