Return-Path: <linux-tip-commits+bounces-8087-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANdbGDYUcWkwdQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8087-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 19:00:22 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0285AE90
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 19:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42BCEB245AE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32A3375DC;
	Wed, 21 Jan 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmkndfLi"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829333343D
	for <linux-tip-commits@vger.kernel.org>; Wed, 21 Jan 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012229; cv=pass; b=raStJ0eO/FTNa1IcZWf+XaYr4sSZxKG6CWpFkWLDjVFhW/hUyeUlYNsZyqkp7qOCcDAWJBI9whqYzPW+lSIMj7knqfU1rrVVF4D4u/oo6NBqfA4nczlmXzXtNBpoWeB3iok220eGexLgETwoouPfmlOU0GdwqMEz2dGYCrotvi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012229; c=relaxed/simple;
	bh=EnezYMjJBEeoERtCgdJJWB5tHj0Gc2U6tbov+6t2DzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwA438g/L6Fed3WeC7UAGOe+pl+b4VbNsYd2NmdxBA71swcSvQ1WFDlocyXrablpjJuZ1/3QF2MAifT/1YVbbrczg1sZ0ob4T8aTMFuUzoJRC7xTJCjwGEQVOH9L7kfwKe3UET1ckJrqaEmre74VUfX0zbmQcVV5lOM60Jbl8r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmkndfLi; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-383122fbc9bso166081fa.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 21 Jan 2026 08:17:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769012225; cv=none;
        d=google.com; s=arc-20240605;
        b=Y0fEDDncLjjrvGKd60omYXARW6C/SQ7F4FgBbCZdG4A+FQIy/H1bPvhIZx/wq+WHNs
         OYuDDbOzXN9QMwKJTFUgZph9T7U4EUZrwuLmVvmD0AogjuyYbN03MHLBcPNAusmzEVDZ
         s7hgFwPbLPTGS9m2bpem2Wv00rR32IFPWYN/al0//YBf9LlE8alY61DQgv6L7otnAMN6
         lItljlpBVRa3HP2z2nU0t4CTFQ8ayU1hgVnm1fxkvQhDR6uLv0o60Jl8hf8CMTWh35AV
         c3wUiZr2FZ20a67fZFz3wZHbqVd0MQfGAJaO1udjpJzWxb3zD4E8hMyJQDH8F89/SP6w
         s+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IbUyMSwkS2THpK+duEm5DQP8Ica4Rv0xGOmFUVH8VYw=;
        fh=pAyB9w5nu4TLwfRrTOh7rux0tg3dzp9pCH6xfv8X/ek=;
        b=erkyahqvYsNHgiO++LZNwzjKpuZkZch6I8IZ2Qp0nkXWLC202Ln8oxRH1isajU+jnC
         WbIZ0xmFXYVnZENI1jv/9oogwliTo1LrKaslxwCO4w9OFtMFWIHITbyvyt8w+nxpi0N0
         dLThNS1oEw47b8a/de83cXiebAbSxxs6tSOGp7ZX/Q+AsbUDunaQ9rj9yrVhkpf8CRRZ
         pr5nguUulMbJbEMzlCAeWuPn9SxTJ87O3iWWWurJdTlenyyRsuPvW9KMGh0lylI14Ida
         CdlTFf+V/0ZWVE7IS+KqKBs3sM3wZOIitlUagVBfygFYK50NaFdgc/qHZBhrGi/qbOpj
         Goew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769012225; x=1769617025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbUyMSwkS2THpK+duEm5DQP8Ica4Rv0xGOmFUVH8VYw=;
        b=VmkndfLiTaZatAUpl2rQRxZIQlsJR5S1Lr2BUpQ07+/q9lpk4gQzyRLorKngDAOG35
         XbUwZLhtBuH3yLBqI7wNzQ9eR07sO2PrqwMMv2GkJPZ83XvPQiepxNVGU7b7Z5Kk1/Su
         gzOEqyZ861IVj+mEqkLVBfFoQzuSjmMzT1iQxUYUDX3i9xVFB73dhrEGvXZ2XkIlHOpU
         8XnGg+3BHZXrCXeuFFXSvGMiTfP4AhbhOBYZogJ/2k1t4qwc92ka1Vov33oLqqiMHvcU
         6jlGfEJXKAO8VqdAoOTj8Y7zIA9NvZDk4N6+JHr1ZAczMgoGOy8ssMwQdCyNSY0sKHHZ
         tPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012225; x=1769617025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IbUyMSwkS2THpK+duEm5DQP8Ica4Rv0xGOmFUVH8VYw=;
        b=KoIC4CC9dh2LWPd2Tl2YG86Ttnwh6fgeyy5RbiZ6GStnCgFtJLcHNswBw9Wx3LNByC
         GSkR+3Xi/PVmmzSV5IAkka+KEqqXxpiVbycWIiBQFPhWbWYhB/WW3drYZzBKcvbAt6Uf
         4xgqfwIWxzD+PvVMVEqmtMAMpNFtYh52bLgvbdkO0qq4si5F61Zjc5/ggQC9uh4nJbl0
         gwtiSrVsbwL/pXbE2vadsNcT2H/T/NCkrUBmE559KmErod16zJwW0QWaZ8979CSxeuST
         e0EEKOBYPd/oQqvt+aiAoKyiqSzxksMlMn2Dx/8JlNAvuskH+nchx9q2dNe8DYfliciG
         aixA==
X-Forwarded-Encrypted: i=1; AJvYcCUGTBe0NprUJte3DSapbQL5Bj1Se4bayp6sZY3apizIL9/zRx99SMBRy+I+JGxB3GSE1nloZqyVuxkn/iykVZhXbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNicEIIiaeCuLLvStQj7Q6dQN+LylLedv0bUER48qiSkWoPPUR
	bPUFt73DprMjlSa7gG8w/ghKpGYG9IQ9KYyWBAIhcpPBJ/YCbWlWDx6to/4tcR9Ife0Xnpmzeyf
	/mutC54Gf1v6/OTDSp/TGxX44zjRBVaE=
X-Gm-Gg: AZuq6aJ+3WQcO0agfWOM/UZadmgpVfV4xn1hqiMwn6T8n26YSZmo7J0W3iQtJCReXg9
	Kj1GwbQ/PQ8Qu/KnbsFJTwKR5pONx8/u/SXLzIT52Sl1dYfF7A+oTNkv0aR/RwF4I7yqINt7vSa
	1ioqXeu5NFf8y57ku36kWwY2NII8K9U+NnZkdpTv0EfNVPIgLgGBWTTqnRUWc/diq4TkBD5ZGe1
	yy9rwgYKt66T2kS09kR4ss6hUMwzNWUmC8RyZGr90YswTf4O3yAki2jG4+DsyQJID1pnJ7cmQP8
	lWq57NCvoBr/jSoouqLFh//aio9n2LmXed4kMQ==
X-Received: by 2002:a2e:bd83:0:b0:383:1d89:8cfa with SMTP id
 38308e7fff4ca-383842dea57mr57965331fa.31.1769012224890; Wed, 21 Jan 2026
 08:17:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105090422.6243-1-ubizjak@gmail.com> <176891088183.510.8607818928752445249.tip-bot2@tip-bot2>
 <3A54B6DC-2462-41DA-8C34-D38CCD2A9A2B@zytor.com> <CAMzpN2gsMdry_v1BKk=e2x1A2Z3W+caaiFzGm7mkotr4SihrYA@mail.gmail.com>
 <20260121140857.3544d19e@pumpkin>
In-Reply-To: <20260121140857.3544d19e@pumpkin>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 21 Jan 2026 17:16:53 +0100
X-Gm-Features: AZwV_Qhs7yi0l7pxnfI94c0waWp_pCDndezu9sEMh7Hqq6ONJq2d6NMeoqqZtqk
Message-ID: <CAFULd4b8hJpY-gAy4MPug1PjK4ME0M_jeBZ68XLjYuSERr7RKA@mail.gmail.com>
Subject: Re: [tip: x86/cleanups] x86/segment: Use MOVL when reading segment registers
To: David Laight <david.laight.linux@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	tip-bot2 for Uros Bizjak <tip-bot2@linutronix.de>, linux-tip-commits@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Michael Kelley <mhklinux@outlook.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8087-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zytor.com,vger.kernel.org,linutronix.de,alien8.de,outlook.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,outlook.com:email,zytor.com:email,linutronix.de:email,alien8.de:email,msgid.link:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BF0285AE90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 5:06=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 21 Jan 2026 06:49:16 -0500
> Brian Gerst <brgerst@gmail.com> wrote:
>
> > On Wed, Jan 21, 2026 at 2:29=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> =
wrote:
> > >
> > > On January 20, 2026 4:08:01 AM PST, tip-bot2 for Uros Bizjak <tip-bot=
2@linutronix.de> wrote:
> > > >The following commit has been merged into the x86/cleanups branch of=
 tip:
> > > >
> > > >Commit-ID:     53ed3d91a141f5c8b3bce45b0004fbbfefe77956
> > > >Gitweb:        https://git.kernel.org/tip/53ed3d91a141f5c8b3bce45b00=
04fbbfefe77956
> > > >Author:        Uros Bizjak <ubizjak@gmail.com>
> > > >AuthorDate:    Mon, 05 Jan 2026 10:02:32 +01:00
> > > >Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > > >CommitterDate: Tue, 20 Jan 2026 12:34:58 +01:00
> > > >
> > > >x86/segment: Use MOVL when reading segment registers
> > > >
> > > >Use MOVL when reading segment registers to avoid 0x66 operand-size o=
verride
> > > >insn prefix. The segment value is always 16-bit and gets zero-extend=
ed to the
> > > >full 32-bit size.
> > > >
> > > >Example:
> > > >
> > > >  4e4:       66 8c c0                mov    %es,%ax
> > > >  4e7:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
> > > >
> > > >  4e4:       8c c0                   mov    %es,%eax
> > > >  4e6:       66 89 83 80 0b 00 00    mov    %ax,0xb80(%rbx)
> > > >
> > > >Also, use the %k0 modifier which generates the SImode (signed intege=
r)
> > > >register name for the target register.
> > > >
> > > >  [ bp: Extend and clarify commit message. ]
> > > >
> > > >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > >Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > > >Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> > > >Tested-by: Michael Kelley <mhklinux@outlook.com>
> > > >Link: https://patch.msgid.link/20260105090422.6243-1-ubizjak@gmail.c=
om
> > > >---
> > > > arch/x86/include/asm/segment.h | 2 +-
> > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > >diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/s=
egment.h
> > > >index f59ae71..9f5be2b 100644
> > > >--- a/arch/x86/include/asm/segment.h
> > > >+++ b/arch/x86/include/asm/segment.h
> > > >@@ -348,7 +348,7 @@ static inline void __loadsegment_fs(unsigned sho=
rt value)
> > > >  * Save a segment register away:
> > > >  */
> > > > #define savesegment(seg, value)                               \
> > > >-      asm("mov %%" #seg ",%0":"=3Dr" (value) : : "memory")
> > > >+      asm("movl %%" #seg ",%k0" : "=3Dr" (value) : : "memory")
> > > >
> > > > #endif /* !__ASSEMBLER__ */
> > > > #endif /* __KERNEL__ */
> > > >
> > >
> > > Incidentally, why aren't we using =3Drm here? Segment moves support m=
emory operands.
> >
> > You would have to be really careful to only use short (16-bit)
> > variables, because it will not zero-extend with a memory operand.
> >
>
> It would be much safer to have something that returned the value
> of the segment register (zero extended to 32 bits).

movl from %seg to 32-bit register (as proposed in the patch)
zero-extends the value all the way to word size (64-bits on x86_64).
The proposed solution also handles memory operands, so:

--cut here--
unsigned int m;

void foo(void)
{
  asm("mov %%gs,%k0" : "=3Dr"(m));
}
--cut here--

compiles to optimal code:

0000000000000000 <foo>:
  0:   8c e8                   mov    %gs,%eax
  2:   89 05 00 00 00 00       mov    %eax,0x0(%rip)        # 8 <foo+0x8>
                       4: R_X86_64_PC32        m-0x4
  8:   c3                      ret

Uros.

