Return-Path: <linux-tip-commits+bounces-7765-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE30CCD34C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 19:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5358C30000A4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F462E0926;
	Thu, 18 Dec 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ClhuB3A"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8482BE02C
	for <linux-tip-commits@vger.kernel.org>; Thu, 18 Dec 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083255; cv=none; b=ZsdEbsmJVCMo34d55bS0jfaYx1TFsx7MdlqBsOlCfSfpgUEcSMnrFH2X0lG+ONozE9oHsW6of8FMh7omKiMcm3j3StDIrXCD1Ee6KqXY261bIhQ8QtJE7NZJIggMvnkvjLG3zz5gCO57sDt9F/Cx+K+JPDSPVrDvpagBALUJ788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083255; c=relaxed/simple;
	bh=RYYbsSApLUmSiLGjx9MRR/PKwa64iCnAviHCFLXAP7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bVMr3b0YM/IlW+GpyQexYmWOR7pOgckrlg2z5l2ozYSaRNHYGUEr0lZGrsxOuGqgQI8ha/L5tP1trrajWaIhuvq0Lto0g0lV/+2nY25SORiZJw7eDg48G9mkCVpQHRoiHNMuOkKcUQQCuHZzXcyRx9jg6gEV5SCnbdjdPDb9y3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ClhuB3A; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so1298322a91.0
        for <linux-tip-commits@vger.kernel.org>; Thu, 18 Dec 2025 10:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766083253; x=1766688053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXXqU4jbywOmCfyBbesOdSVLl4kVgayMGQ9AhPMyorU=;
        b=3ClhuB3A4RlYnrJabgTSEFwDRJjGvObPbGkKi/3wxjlxcf6E+YoJp9hnRZf/yzysIU
         EQQVVgCrRU6Y41CUDDDwUlOPe5k1bQwQdrDeiCIEQG8CxMJxFildW+Sdadw2MW5cMiwN
         85CHMPOSe3wVo3ygvwuJD7zFlkKyoq8kUjlDoos+94pphxFVa/Q7DncQKjPO+H4iJKr7
         cq5gezszCcbqnWAlLysvY8va8ITWeEhtVnVDlVXP5Aiu7ENOLgDKxaxmudMbCfBuwOVD
         uRq7RQS154l+OdXdC2Q2mZuSgVR3aNUrJfOSvX6Ya51y1HyT8epAkuyJvvp/zSHEQEq7
         vF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766083253; x=1766688053;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qXXqU4jbywOmCfyBbesOdSVLl4kVgayMGQ9AhPMyorU=;
        b=QyLLHVCgBCkI9+1nq3Ef8NeKRUvQXF3oanu4VI3QX6MPz684mSJXtqVu5tqzrpg4rb
         wnX+8ySAo9SA0l4l9/IBPerrvJhnaJ1fPbR+0mpJOhov/WBpsrY5ydg9cO/jHujtE71j
         vun/uBSV+t7mSM78tUg2UfVXzctXXjpgnwlinXxBc/Z2PNjjJiKM6sMNVIFflBC0C4Lq
         4F+c6MMhg0sIpADtsm3kopevxEHiKQ5iUbswnmMw1HQpCWxke1PfpNIn4qAEWHihg4nu
         BhKdAp3MKxJeAmXHxejDrWAwyLwxMHl1Ya2DWKtTYPqJM7XKNJMVA2VQ5CLMK7PPr5cy
         eEbw==
X-Forwarded-Encrypted: i=1; AJvYcCWJBo/tptvH30alD5Ryxd+Ji+KbtrkJjzSbbAVb7zfTSaKDZe8GYjOTHy6ZJ7uNdHsk7AUpbz/3AtdBLEMZrKc8pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAkJTCdMPdUIIa33NdUTGqzl8SKAltfUMt3zYeVAgHwtWAEvc
	SuSCxwQhQLA62JdVHSTjO6QQHn1itPGMrkg1CZfPadY54tM1ZCQHc0FoApyKc1c8/OSSZVV2Qy1
	XH4OB8A==
X-Google-Smtp-Source: AGHT+IHwIK+8v+VK9tU3i7xm3ePKwmKmQsQMB3JoeqAXbjt4LHZxEpdn/la1a2+MaxxOCof88uAiv0k1myM=
X-Received: from pjbgq23.prod.google.com ([2002:a17:90b:1057:b0:34c:ab9b:76d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7c9:b0:32e:7340:a7f7
 with SMTP id 98e67ed59e1d1-34e921131admr254464a91.2.1766083252671; Thu, 18
 Dec 2025 10:40:52 -0800 (PST)
Date: Thu, 18 Dec 2025 10:40:51 -0800
In-Reply-To: <20251218083346.GG3708021@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251208115156.GE3707891@noisy.programming.kicks-ass.net>
 <176597507731.510.6380001909229389563.tip-bot2@tip-bot2> <20251218083109.GH3707891@noisy.programming.kicks-ass.net>
 <20251218083346.GG3708021@noisy.programming.kicks-ass.net>
Message-ID: <aURKsxhxpJ0oHDok@google.com>
Subject: Re: [tip: perf/core] perf: Use EXPORT_SYMBOL_FOR_KVM() for the
 mediated APIs
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025, Peter Zijlstra wrote:
> On Thu, Dec 18, 2025 at 09:31:09AM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 17, 2025 at 12:37:57PM -0000, tip-bot2 for Peter Zijlstra w=
rote:
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index e6a4b1e..376fb07 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -57,6 +57,7 @@
> > >  #include <linux/task_work.h>
> > >  #include <linux/percpu-rwsem.h>
> > >  #include <linux/unwind_deferred.h>
> > > +#include <linux/kvm_types.h>
> > Bah, so the !KVM architectures hate on this.
> >=20
> > Sean, would something like this be acceptable?
>=20
> Hmm, the other option is doing something like so:
>=20
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 376fb07d869b..014d832e8eaa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -57,7 +57,6 @@
>  #include <linux/task_work.h>
>  #include <linux/percpu-rwsem.h>
>  #include <linux/unwind_deferred.h>
> -#include <linux/kvm_types.h>
> =20
>  #include "internal.h"
> =20
> @@ -6325,6 +6324,8 @@ u64 perf_event_pause(struct perf_event *event, bool=
 reset)
>  EXPORT_SYMBOL_GPL(perf_event_pause);
> =20
>  #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
> +#include <linux/kvm_types.h>

Hrm, quick and dirty, but I don't love the idea of punting on the underlyin=
g
issue, because not being able to include kvm_types.h will be a big deterren=
t to
using EXPORT_SYMBOL_FOR_KVM().

>  static atomic_t nr_include_guest_events __read_mostly;
> =20
>  static atomic_t nr_mediated_pmu_vms __read_mostly;
>=20
> > ---
> > Subject: kvm: Fix linux/kvm_types.h for !KVM architectures
> >=20
> > As is, <linux/kvm_types.h> hard relies on architectures having
> > <asm/kvm_types.h> which (obviously) breaks for architectures that don't
> > have KVM support.
> >=20
> > This means generic code (kernel/events/ in this case) cannot use
> > EXPORT_SYMBOL_FOR_KVM().
> >=20
> > Rearrange things just so that <linux/kvm_types.h> becomes usable and
> > provides the (expected) empty stub for EXPORT_SYMBOL_FOR_KVM() for !KVM=
.
> >=20
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> > diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> > index a568d8e6f4e8..a4cc13e41eec 100644
> > --- a/include/linux/kvm_types.h
> > +++ b/include/linux/kvm_types.h
> > @@ -6,6 +6,8 @@
> >  #include <linux/bits.h>
> >  #include <linux/export.h>
> >  #include <linux/types.h>
> > +
> > +#ifdef CONFIG_KVM
> >  #include <asm/kvm_types.h>

This won't work, because asm/kvm_types.h #defines KVM_ARCH_NR_OBJS_PER_MEMO=
RY_CACHE,
which guards the "struct kvm_mmu_memory_cache" definition.  E.g. on x86 wit=
h
CONFIG_KVM=3Dn, that yields errors like:

  In file included from include/linux/kvm_host.h:45,
                   from arch/x86/events/intel/core.c:17:
  arch/x86/include/asm/kvm_host.h:854:37: error: field =E2=80=98mmu_pte_lis=
t_desc_cache=E2=80=99 has incomplete type
    854 |         struct kvm_mmu_memory_cache mmu_pte_list_desc_cache;
        |                                     ^~~~~~~~~~~~~~~~~~~~~~~


In general, I'm hesitant to guard an include with a conditional Kconfig, pr=
ecisely
because doing so has a tendency to result in wonky, config-specific build e=
rrors.

Rather than gate the check on KVM being enabled, what if we restrict the as=
m
include to architectures that support KVM in any capacity?  Alternatively, =
we
could add a HAVE_KVM, but I'd rather not add HAVE_KVM, because then we'll e=
nd up
with the same mess if architectures get clever and conditionally select HAV=
E_KVM
(IIRC, that's exactly what happened when HAVE_KVM was a thing in the past).

Compiled tested on all KVM architectures along with csky (and an include of
kvm_types.h in init/main.c).

--
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Dec 2025 15:47:59 +0000
Subject: [PATCH] KVM: Allow linux/kvm_types.h to be included on non-KVM
 architectures

Include the arch-defined asm/kvm_types.h if and only if the kernel is
being compiled for an architecture that supports KVM so that kvm_types.h
can be included in generic code without having to guard _those_ includes,
and without having to add "generic-y +=3D kvm_types.h" for all architecture=
s
that don't support KVM.

Assert that KVM=3Dn if asm/kvm_types.h isn't included to provide a more
helpful error message if an arch name changes (highly unlikely) or a new
arch that supports KVM comes along.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_types.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..797721e298df 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -6,7 +6,23 @@
 #include <linux/bits.h>
 #include <linux/export.h>
 #include <linux/types.h>
+
+/*
+ * Include the arch-defined kvm_types.h if and only if the target architec=
ture
+ * supports KVM, so that linux/kvm_types.h can be included in generic code
+ * without requiring _all_ architectures to add generic-y +=3D kvm_types.h=
.
+ */
+#if defined(CONFIG_ARM64)	|| \
+    defined(CONFIG_LOONGARCH)	|| \
+    defined(CONFIG_MIPS)	|| \
+    defined(CONFIG_PPC)		|| \
+    defined(CONFIG_RISCV)	|| \
+    defined(CONFIG_S390)	|| \
+    defined(CONFIG_X86)
 #include <asm/kvm_types.h>
+#else
+static_assert(!IS_ENABLED(CONFIG_KVM));
+#endif
=20
 #ifdef KVM_SUB_MODULES
 #define EXPORT_SYMBOL_FOR_KVM_INTERNAL(symbol) \

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
--=20

