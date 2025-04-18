Return-Path: <linux-tip-commits+bounces-5055-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967FBA9332C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 09:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8410168A72
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 07:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417421325C;
	Fri, 18 Apr 2025 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOb7fReI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66D8C0E;
	Fri, 18 Apr 2025 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744959924; cv=none; b=o7aFkeAaufRPjjFsz2kxY+xgPuZsXDreG7VcHDvDgOejDhkwTW2VCPI+knjKfP53PEQZQHrfofa4XSpc8PRGYgo8x+6Y43EHrfd+O1FPQG/+a0U+mhzZUG2ZxE/QX1lqcmLJmsDvlNk9nGXhU98amVfGdaAzUGqdeD3ec7bXBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744959924; c=relaxed/simple;
	bh=KBWytEzvIXK4gEe9LdE7ZJpPSwTE8tFcqoRCCQHJUKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAyTk1QJ8OmbZvk4hO9mEgDxNhT1rEU8hBd+H240EIxdlPJQOHqr0QWfCD+s02IRIJo6huW0vU/33wkBcWmM9dwrrGHrXcLqoIQM7Jk4Qcll08rfYIPkG2XId2+sAw94PyL2c2PgSL95zQ36SX62uiiLY0mCTQwCKARQLA1ixZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOb7fReI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E79AC4CEE7;
	Fri, 18 Apr 2025 07:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744959923;
	bh=KBWytEzvIXK4gEe9LdE7ZJpPSwTE8tFcqoRCCQHJUKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KOb7fReIoOl+1kQirFw0QwxSDEGKez1RizxewAr1V63GXoaLrhQB9kni1Z1qT7Rub
	 ti70+13q6ifHqheVX016ecTg09EtO3MsPy5tD78uI4hVWR0rj8S7MRbJYb7br/fWo3
	 xrD//xOXW0OEGRDSubGKNZKR27onwKzMptgLrtsQNi6Br+BPv/DwMjczMsVz4cBa9Z
	 f2p3y01lJPRhFQt3SitjjESDSWiynE2SblDWqy1zKc1qxaIeP/5EnDhW9G9brHOjjQ
	 kzYDJngxcp4tdOXHwqLBw5dEOp9iaDkWLI5KQPaA1BVnHxMsaUSR7Wo0+BKnL8tI4l
	 pgmaJb5PGMtog==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so2186890e87.2;
        Fri, 18 Apr 2025 00:05:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2qVtGcEk9P6TEnJ2vixn7XoGalagUPrnfo494TQIroakJDdoLoWb1qlMxazISxZpo4aEBsl5ySHDFQM0Xov7WrS4=@vger.kernel.org, AJvYcCWSCYWOauJ1IO5IqThWdENcVMSvqVpD9z0UgxYioW3SSc5mg/BqroHGh6noea4Xc5cAEBIop9hl+skwGXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6ltM9b58uW0fpRGSZYop4fvfdwhMkN6w7tapqHHbk4Iohf3P
	ZwuPart8FjkrIs6vmvrAUgmIeLQNBJvohB1N4ikgfjdbERC8Wp/n7Zj7uVwVwDvIMRGJfRWVKT0
	+t6C1vYKQQI5hvPt5OkSmxj8SnP0=
X-Google-Smtp-Source: AGHT+IF1vvWYSlieY57kroMtUhKs+syOnJM4QZdLDfSdU7K4Gqax0E2ezt34ZfxGcBDMosbhCdaM2T73K8LeYC9BbXo=
X-Received: by 2002:a05:6512:b28:b0:549:792a:a382 with SMTP id
 2adb3069b0e04-54d6e635987mr478097e87.32.1744959922030; Fri, 18 Apr 2025
 00:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307164801.885261-2-ardb+git@google.com> <174138907883.14745.965399833848496586.tip-bot2@tip-bot2>
 <364ad671-5e5c-47c1-af22-34a7c481f8e3@intel.com> <2fddc2e9-8c97-48de-bcc3-29645d58f0f1@intel.com>
 <Z_oo3eBywzj6s8Eg@gmail.com>
In-Reply-To: <Z_oo3eBywzj6s8Eg@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 18 Apr 2025 09:05:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGzSK0YxdiGsK9b4ph8dqt08fXFQkWYBg9VFerSwowZUg@mail.gmail.com>
X-Gm-Features: ATxdqUG0Cm9QjGkUxRV_oVu3d7YwLUoAlr8-PwK7dw88P7VsxPlkdUhIQz59-Tw
Message-ID: <CAMj1kXGzSK0YxdiGsK9b4ph8dqt08fXFQkWYBg9VFerSwowZUg@mail.gmail.com>
Subject: Re: [tip: x86/build] x86/boot: Drop CRC-32 checksum and the build
 tool that generates it
To: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Ian Campbell <ijc@hellion.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 10:48, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Dave Hansen <dave.hansen@intel.com> wrote:
>
> > On 4/11/25 12:33, Dave Hansen wrote:
> > ...
> > > The only weird thing I'm doing is booting the kernel with qemu's -kernel
> > > argument.
> >
> > I lied. I'm doing other weird things. I have a local script named
> > "truncate" that's not the same thing as /usr/bin/truncate. Guess what
> > this patch started doing:
> >
> > >  quiet_cmd_image = BUILD   $@
> > > -silent_redirect_image = >/dev/null
> > > -cmd_image = $(obj)/tools/build $(obj)/setup.bin $(obj)/vmlinux.bin \
> > > -                          $(obj)/zoffset.h $@ $($(quiet)redirect_image)
> > > +      cmd_image = cp $< $@; truncate -s %4K $@; cat $(obj)/vmlinux.bin >>$@
> >
> >                                ^ right there
>
> Oh that sucks ...
>
> > I'm an idiot. That was a poorly named script and it cost me a kernel
> > bisect and poking at the patch for an hour. <sigh>
> >
> > Sorry for the noise.
>
> I feel your pain, I too once overlaid a well-known utility with my own
> script in ~/bin/. After that incident I started adding the .sh postfix
> to my own scripts, that way there's a much lower chance of namespace
> collisions.
>

There was another report about this, but in that case, the problem was
that busybox's truncate clone does not understand the % notation (even
though the very first original truncate version that I found from 2008
already supported that)

In any case, we might change this to

--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -59,7 +59,7 @@
 $(obj)/bzImage: asflags-y  := $(SVGA_MODE)

 quiet_cmd_image = BUILD   $@
-      cmd_image = cp $< $@; truncate -s %4K $@; cat $(obj)/vmlinux.bin >>$@
+      cmd_image = (dd if=$< bs=4096 conv=sync status=none; cat
$(obj)/vmlinux.bin) >$@

 $(obj)/bzImage: $(obj)/setup.bin $(obj)/vmlinux.bin FORCE
        $(call if_changed,image)

which is slightly cleaner - I'll send out a patch once I receive
confirmation that busybox dd implements conv=sync (which takes care of
the padding) correctly.

