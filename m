Return-Path: <linux-tip-commits+bounces-8086-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFYvGg0WcWmodQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8086-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 19:08:13 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C55A05B0C1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 19:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 619B970E898
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 Jan 2026 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7A34218BF;
	Wed, 21 Jan 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN59rw6O"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659F410D13
	for <linux-tip-commits@vger.kernel.org>; Wed, 21 Jan 2026 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011401; cv=none; b=cgBWuDzBxlj0vOQ4Fi7sjKeAWWfO6p6PRwn6/D5ZR/y/y5mH4o4lnDAwCZ9xAuCvN635+aZGnVzZsQHBHX+Pfu+iEqwxZkSXyIvsePhGlCIA6mmshj9XHSnGOmolQByvwpRrHOm/eADiq7F/zwF9zuBVKFC3lh/XvCi+hwy/qa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011401; c=relaxed/simple;
	bh=MSrdElO2eNJ+3fVFv82fRnLpxJGYKhhFl9vi/KvX9Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPlSXv9CoqP8vqGPOaXt4HALTFQkds3gkN790eD3XxVCjsX9gsrO/04QoPVXpO3LTix6YYfqhc9tqaCgzeoczAWaPPwZN0Tu6PpLo+m7GxIp6LA1MS6zciPV5kAw7STd/sRnf7PNt8C/K1XodrYgI8DE8jOJsWiUiKIZGZqi1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN59rw6O; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65812261842so1845428a12.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 21 Jan 2026 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769011398; x=1769616198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/1aNZ9XJSzadYv8zTigHAL/WcmkL36YjSibotwpTDQ=;
        b=dN59rw6Ojm54587X2T1YSWJYozprTfQR1MRbg1JdqKDTn01h0kdydQDUSk3Xu0/TPt
         D7NDrdEEKQe5nETobU+txNlpbWVeRqSs/F6tx3kGsw/xJoUSo5L5I667EiwLB3Mp0/sU
         tpvjqkPl0N6tn2qpZeiq6WkgV3xqClV2aCjwHmjacDzg/qqiDokcSyCvobgS/yw207DK
         XlEI7nArQHUp7dC7FCUrp65glBnxOdxg4X75Qp/QxakfwURgvyh6H+O85u7UeBasR8EH
         f54yuV8GWICAx5VpHcVU5GF3brfhaw+vQL+RUleTWURvFitoWQfCUBGmsXbLQFkuA/ju
         bFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011398; x=1769616198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/1aNZ9XJSzadYv8zTigHAL/WcmkL36YjSibotwpTDQ=;
        b=VjXAuHI6hMrgkIoD9m0Cwph2Mhb8JgPujqWo9lWnwJMF9uZFYoTbXuaR7Y3Rc2lBQb
         R/uKiUFG5WanhM9iJl5h0gXn3hARbZN1ZcYBEISdyqX7q3F56jfrueaz8VbSHG1NhfHS
         6Kdz5kK6o/vkXaax82f/XMcJDKLuT2/Q9UeNna5E3ZHT9wMdiZuiF6hvMJquJAkRRga2
         LABDYc1updRSOGQNH4rXmYuqridiOeV+4V78OZIt3Uj5lxY4esahbukJqBWHcmgEtpi2
         3u6F/4cyHmg4KVA1JYvtwhsLbS9ZJORJInJ+vPMuKijQo6XmTtHV4Z8skheCyQJCl2Un
         eo7g==
X-Forwarded-Encrypted: i=1; AJvYcCVkd4i6tIufb3u3w8qX7XuqeQ1HqWEJdjwtMrr8GKC0vM/hx+5+/jhzQF9EFQxfKrvRyRb+hzc4yv1SgTV0PKhkZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTff8tOHHKsmz7BxxdK+P3//xJoNNCG9z1Oz+Z6UugXLtUIJCr
	NPkbuy/YcvVWoqCeDo0ZP27LsIchk8Wi4hyJkPwNWZjUKU5kTPXf06Dx5tV5iQ==
X-Gm-Gg: AZuq6aKdRLek/8IYVfrL6pIE8/r8kj3Jx6It+AwlHZ3gzzZ8SUsoSq7b5lyRYyoJnqs
	TODNacSmfazZfN8mrAw6mwnAq4+DCg+tdoIlFXgsofM25pgPZERV0It/k3DJlexS0bU+xDY0mGr
	vBYWhKo+4AH5WzTmrAYAcyS0p6QWa2OKNEmFuSqXbF5kgHQSISIGXKLiuKMCcWA+CQWejLfuven
	9XCTLilXTtRYIIS1B0aF1hgsmRi3LZ14kcJiyFCRuRVWeP+FKCjMzVYaEcg9XqySrDUZ02fJ4Ry
	aJVO5pasDHOz5uFqNvEmhDfwt33JcBXaTbB70uOzOtHqLNNc/oByi6gM7NixoY62l1vjcmWzcZj
	3o/6VnvTcAbQRB1f5j8lUGddb2VHC5adjSyocSB7tbWo7b8b/3ushNt7uJgjc8QDBV4rx4GEk+h
	JPjkdsOQWGbDThIPf5rPA7CMdxAe0DvoQRRTrIVOEOkHyalRRgDGT8
X-Received: by 2002:a5d:6502:0:b0:435:8dd5:ad4f with SMTP id ffacd0b85a97d-4358dd5af25mr7713381f8f.9.1769004539390;
        Wed, 21 Jan 2026 06:08:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f138e26sm11918651f8f.17.2026.01.21.06.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:08:59 -0800 (PST)
Date: Wed, 21 Jan 2026 14:08:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, tip-bot2
 for Uros Bizjak <tip-bot2@linutronix.de>,
 linux-tip-commits@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Michael Kelley
 <mhklinux@outlook.com>, x86@kernel.org
Subject: Re: [tip: x86/cleanups] x86/segment: Use MOVL when reading segment
 registers
Message-ID: <20260121140857.3544d19e@pumpkin>
In-Reply-To: <CAMzpN2gsMdry_v1BKk=e2x1A2Z3W+caaiFzGm7mkotr4SihrYA@mail.gmail.com>
References: <20260105090422.6243-1-ubizjak@gmail.com>
	<176891088183.510.8607818928752445249.tip-bot2@tip-bot2>
	<3A54B6DC-2462-41DA-8C34-D38CCD2A9A2B@zytor.com>
	<CAMzpN2gsMdry_v1BKk=e2x1A2Z3W+caaiFzGm7mkotr4SihrYA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-8086-lists,linux-tip-commits=lfdr.de];
	FREEMAIL_CC(0.00)[zytor.com,vger.kernel.org,linutronix.de,gmail.com,alien8.de,outlook.com,kernel.org];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,alien8.de:email,zytor.com:email,msgid.link:url,outlook.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C55A05B0C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 06:49:16 -0500
Brian Gerst <brgerst@gmail.com> wrote:

> On Wed, Jan 21, 2026 at 2:29=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wr=
ote:
> >
> > On January 20, 2026 4:08:01 AM PST, tip-bot2 for Uros Bizjak <tip-bot2@=
linutronix.de> wrote: =20
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
> > > =20
> >
> > Incidentally, why aren't we using =3Drm here? Segment moves support mem=
ory operands. =20
>=20
> You would have to be really careful to only use short (16-bit)
> variables, because it will not zero-extend with a memory operand.
>=20

It would be much safer to have something that returned the value
of the segment register (zero extended to 32 bits).

	David

