Return-Path: <linux-tip-commits+bounces-103-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521F982731A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jan 2024 16:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9701C22C3C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jan 2024 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDB451008;
	Mon,  8 Jan 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8XvTMFz"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF951019
	for <linux-tip-commits@vger.kernel.org>; Mon,  8 Jan 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so13974a12.1
        for <linux-tip-commits@vger.kernel.org>; Mon, 08 Jan 2024 07:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704727729; x=1705332529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Isb5ut/bgR2/r/5F9YVy69h9kXC52tbAkHmnKiVEMAY=;
        b=L8XvTMFz+FqT5IYD+cdWuhRKyF3Ar0k6TDArT+GP5KsonDmtexmzwyMVYZLMEln0Qd
         YUVRsk8BPr0gNjDIugXnsoaKxr7zRz1WKiqjixe5jEMU42V+FjfpRflOXURylYL+yOq4
         0uVk4gxuSV5203Rp9qIWFrEie8slfuDjbArzC7G/T4RJfSL24MF8A68ZLuPB4ky9wXlI
         SjiBjlFOYshvPC5P2K/JKpMUsqTwrGIi0SwCZhmSMeCCynu1XrDe6eXOH5nA0CANshNr
         tHwWIW+deNMZCtLdpG0siNJdojg7hT+Y+wrzguNBKOJrwqkBPCTIXe+qcIEAxLcKii+G
         6BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704727729; x=1705332529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Isb5ut/bgR2/r/5F9YVy69h9kXC52tbAkHmnKiVEMAY=;
        b=sFjvKUz4SrUauxaID8+ugMO4Fl2yjIKOPd3a12r9LmeY2w8ScspVRaT5kU5Zz//jqx
         tNPpRZQ4eS23TEnWISs7JP/RJ121Dh/Vh6IPiXKkUjthGc4CCP3xkE66/Ts0pmazMRXX
         lugMMWI9yTFkSn+Qhk/5SXJFCYIbH5Bxd9YhCJJIK6GmsK5miGgvXrRmZfKpd6Isdtez
         OVx0pfHXek+5fJ6wjWnr2vAPIZZ7d6RZHp+wXkq1IDQhgvC3Qc24PVEZY4uxkZtdwPqs
         +apv2ph1nzDxaUvGyY1DK7tqs8r9XuFeBcT6xJCe8ZYGrM1H4cmSyZ+wo7usKjnsu4hd
         03VA==
X-Gm-Message-State: AOJu0YzzFYrTPa07QR0oCeVmQg4egrEVXF0DJXkxzZtNMyKdBVoIbTvO
	fhDQgPZXgF7kfAPMjLoUW7Y86pYCL44d2LFEQjs3bZrA/JMGivDtKhYb9RMw3yuv
X-Google-Smtp-Source: AGHT+IHj/hq+6ybdQUvW8IbBNJtuct1zKTEIHf3ZIq7kIXyUg1Av9/t8o646IQy69IltOXBD+zdKfjnHF7CGKOGeBPI=
X-Received: by 2002:a50:8a93:0:b0:554:2501:cc8e with SMTP id
 j19-20020a508a93000000b005542501cc8emr282070edj.6.1704727728768; Mon, 08 Jan
 2024 07:28:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130204817.2031407-1-jannh@google.com> <170142744948.398.4203675877225809071.tip-bot2@tip-bot2>
 <20231201121808.GL3818@noisy.programming.kicks-ass.net> <ZZu2F8KNygWzWVY7@gmail.com>
In-Reply-To: <ZZu2F8KNygWzWVY7@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 8 Jan 2024 16:28:11 +0100
Message-ID: <CAG48ez0pO9sfNfW35q5qjoWr+_s5_16t=gTC+kU-j1LGkA-SMQ@mail.gmail.com>
Subject: Re: [PATCH] locking/mutex: Clarify that mutex_unlock(), and most
 other sleeping locks, cannot be used to reference-count objects
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 9:45=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Fri, Dec 01, 2023 at 10:44:09AM -0000, tip-bot2 for Jann Horn wrote:
> >
> > > --- a/Documentation/locking/mutex-design.rst
> > > +++ b/Documentation/locking/mutex-design.rst
> > > @@ -101,6 +101,12 @@ features that make lock debugging easier and fas=
ter:
> > >      - Detects multi-task circular deadlocks and prints out all affec=
ted
> > >        locks and tasks (and only those tasks).
> > >
> > > +Releasing a mutex is not an atomic operation: Once a mutex release o=
peration
> >
> > I still object to this confusing usage of atomic. Also all this also
> > applies to all sleeping locks, rwsem etc. I don't see why we need to
> > special case mutex here.
> >
> > Also completion_done() has an explicit lock+unlock on wait.lock to
> > deal with this there.
>
> Fair enough - but Jan's original observation stands: mutexes are the
> sleeping locks most similar to spinlocks, so the locking & object lifetim=
e
> pattern that works under spinlocks cannot be carried over to mutexes in a=
ll
> cases, and it's fair to warn about this pitfall.
>
> We single out mutex_lock(), because they are the most similar in behavior
> to spinlocks, and because this concern isn't hypothethical, it has been
> observed in the wild with mutex users.
>
> How about the language in the attached patch?

In case you missed it, I sent this rewritten documentation patch in
response to the feedback I got, intended to replace the patch that is
now sitting in the tip tree (but I don't know how that works
procedurally for something that's already in the tip tree, whether
you'd want to just swap out the patch with a forced update, or revert
out the old version, or something else):
<https://lore.kernel.org/all/20231204132259.112152-1-jannh@google.com/>

Since there were comments on how this is really a more general rule
than a mutex-specific one, that version doesn't touch
Documentation/locking/mutex-design.rst and instead documents the rule
in Documentation/locking/locktypes.rst; and then it adds comments
above some of the most common unlock-type functions that would be
affected.

