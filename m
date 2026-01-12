Return-Path: <linux-tip-commits+bounces-7891-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02586D14665
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 18:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 716133043F6E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 17:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37620376BF5;
	Mon, 12 Jan 2026 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzrPv7MC"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D6240604
	for <linux-tip-commits@vger.kernel.org>; Mon, 12 Jan 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239180; cv=none; b=KXaIuNSl4HzZ2MI1YxRclej2dxoZ8skS5FkcpQFaTegTjZITiOqhXZ4wdoBtsVsV1g0N1TBrafE8oYtIFA87fiZKwGr0kq8rOmljDGN4Z3ijyHL+bDZ4I1KWb1hoq94UfU4dxaKzyrklz468/TrfCRQ+lFs5reHZKtRFmCNu2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239180; c=relaxed/simple;
	bh=WUC+MeIUCyl/4KbuLLShpYe3QW5bjByFvDBN5XnC+HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOX7UzH5ui7n7og7hBQAT67b+gWn1BKm4UK6D5KTJlyvlXGJFy+ONYi22PzKz3d7JvHcVlW+9yn4pdrn8XRrkDkE4X5RcGKqh4HpQvByHa4ESbNs8pATe7tPjKYVZP2I/BUJkobp00UWbBFt28GnJzw+pxqcTi9WB0aytjI93YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CzrPv7MC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64ba74e6892so11005051a12.2
        for <linux-tip-commits@vger.kernel.org>; Mon, 12 Jan 2026 09:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768239177; x=1768843977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM2kssEJYv7ymsVQtY2+XCFtC+esRghVpEFgJ0MLopA=;
        b=CzrPv7MCsIEial4XnszrMM5agJ+YucngwtiJ/QWY6a3lc2MsPlcjZ4mM/Hz1LGjea5
         P8gqfuB44xGHudX/wzf1jvzih7jV8meR6gvQoNHh1MMfe9pY40mKcKBZeZTqAkWnFZwZ
         omRXK/cYNnvai05a5H0T+B1emYQ9uvAZMlrzgFAiNai2g+odvQGNfmoKXQ6wUo8UBazz
         FsDO5KQ7IIZ3IyGirGmdg69JXGsCmSPv3dU7Ho41HFXoFje9lgewwR37j9Z2PnBjNc4a
         8GlAKLkEzmVevE/c2rBnMZP5RY84H1j0SqPbzRnnTICMGmV8QFlDAXBaHWjuaEPiKm2W
         a5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239177; x=1768843977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iM2kssEJYv7ymsVQtY2+XCFtC+esRghVpEFgJ0MLopA=;
        b=HcRdq0csygjgVqd7Q3nSIR/Y++lqmFxWJuXa0s1cOlJQ3ytvyZzYh4+4Zen07OuOHQ
         RJ8tKuyevOORuIZlYUM4B/gdhbuEi9H1gD8D5wEruqkuZ7wEdI/HSoP6Gow/PFAnPWqo
         +N8BnaY5v/kMpjJMim7M65fFpF/QPfhN0kp27UAoNcst11ZzxUBtSbWWqvzKCAiErY/g
         n5vYw8N2ONdDI8eEDRHn5sqgzwUGXcLTgt2ISyp7FdYAfULUoUELBJUtRNPLjTULVV1/
         Ib0D+TEtmm8UB8wEr/a++aVl/80Y/RXjtrxBrYEUl5xal3vMFrXqQ+AcLDRxDnXU8qKN
         M68A==
X-Forwarded-Encrypted: i=1; AJvYcCVGWioCMqVmpY/hlDrADtqh4QFEoMkePosfY0bJANml2owZI/XLE25aWxXu65T5NP6/QI4JmUunym6YFxyLpdBaOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoH6X3De6pU/US6tnu7UNgp/HcPZFbVf2wDIVjvH0hX+P6EGj
	Yl9K/C1JDTux45HO+sHVYhgGtq7aMbVVFiJgauBwZk0ihVhsxIuy3w381E+Wr7WZ6j1q/CTy7zS
	0cTvinFReCtUZItYvNMomUlYjtp6NZ0Zv1cTE1jMEVw==
X-Gm-Gg: AY/fxX5HdFUVlinEeK0GIxiAFF3J1y+isIBKQBtXPPv/1pbDDtPKDRG92lSnKtDWv3W
	9Bjxrna2A+thGOkna0qEP7Q7q8kYaxB8sMLsejTyVzkaFK9aU5LVQ1gjLu01WzRQjvRpZ0r8wBd
	Zt3XRoOTAobmrw7OxW3Fcu5sohY+TWMuFVyDVemLttp1JpNFJudXlCK/DLhXMC6E5IVcPx8nJcU
	oxhfeWdafAv+ZcolLf4A0Yu/SDnQtZUz8O5ewMT0LXdcruDEuSvuvr+uq9WZ5pUuj+qsnckpXNm
	Ce4bZyJOGP/JPgYF/AdxMx94
X-Google-Smtp-Source: AGHT+IELk6CVQZfO9UfQqyPTvLwq1WuROVOTsCJJHJAbRXuj9j1wZgtdyJ0k5YY+w89YzJghh84riWGmrylwucZar5c=
X-Received: by 2002:a05:6402:348a:b0:64b:6e44:217 with SMTP id
 4fb4d7f45d1cf-65097ceaecemr16728252a12.0.1768239176691; Mon, 12 Jan 2026
 09:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176478073513.498.15089394378873483436.tip-bot2@tip-bot2>
 <20251229125109.1995077-1-CruzZhao@linux.alibaba.com> <CAKfTPtCQW_Oj+P6nGx0nVO01CahSEqxuToO8kg=oe3yfuViOwg@mail.gmail.com>
 <aVh1Fiar6aC4W_1D@templeofstupid.com>
In-Reply-To: <aVh1Fiar6aC4W_1D@templeofstupid.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Jan 2026 18:32:44 +0100
X-Gm-Features: AZwV_QirygSvzfAgzNETr9h6JwgMh31Mp4mnCBzjS7xWYWFjzCsn3IMd6y46J2A
Message-ID: <CAKfTPtC42qVKbng8bb8G4ebVz4PQ1HF3N5cyK3U0S37zxbTy-g@mail.gmail.com>
Subject: Re: [tip:sched/urgent] sched/fair: Clear ->h_load_next when
 unregistering a cgroup
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Cruz Zhao <CruzZhao@linux.alibaba.com>, tip-bot2@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	mingo@kernel.org, x86@kernel.org, Peng Wang <peng_wang@linux.alibaba.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 3 Jan 2026 at 02:47, Krister Johansen <kjlx@templeofstupid.com> wro=
te:
>
> Hi Vincent,
>
> On Mon, Dec 29, 2025 at 02:58:16PM +0100, Vincent Guittot wrote:
> > On Mon, 29 Dec 2025 at 13:51, Cruz Zhao <CruzZhao@linux.alibaba.com> wr=
ote:
> > > I noticed that the following patch has been queued in the
> > > tip:sched/urgent branch for some time but hasn't yet made
> > > it into mainline:
> > > https://lore.kernel.org/all/176478073513.498.15089394378873483436.tip=
-bot2@tip-bot2/
> > >
> > > Could you please check if there's anything blocking its
> > > merge? I wanted to ensure it doesn=E2=80=99t get overlooked.
> >
> > From an off list discussion w/ Peter, we need to check that this patch
> > is not hiding the root cause that task_h_load is not called in the
> > right context i.e. with rcu_read_lock(). Peter pointed out one place
> > in numa [1]
> >
> > [1] https://lore.kernel.org/all/20251015124422.GD3419281@noisy.programm=
ing.kicks-ass.net/
>
> If it helps, I've double-checked this code a few times.  When I looked,
> there were 7 different callers of task_h_load(), and they decompose into
> 3 cases.
>
> 1. rcu_read_lock is held as we expect
> 2. the numa balancing cases Peter already identified
> 3. tick related invocations, where the caller is in interrupt context
>
> For 3, there's an edge case where deferred work is scheduled if the
> target cpu is in full nohz mode and has stopped.

Thanks for this analysis. I'm aligned with your conclusion that we
have 2 calls which are not protected
-task_numa_find_cpu
-sched_tick_remote

>
> In the cases where I'm hitting this bug, the systems aren't using numa
> balancing and aren't using nohz. 90% of ones I've analyzed are in a
> futex wakeup and are holding the rcu_read_lock.

Do you have a simple way to reproduce it ?

>
> This seems like just a case of the pointer continuing to reference
> memory that was already free'd.  If the task group's sched entity is
> freed, but the parent cfs_rq still has a pointer to that sched_entity in
> h_load_next, then it may end up accessing that memory accidentally if we
> do not clear it.

I agree that rcu protection does not prevent cfs_rq->h_load_next from
holding a ref to the freed sched_entity after the grace period and
until update_cfs_rq_h_load() overwrites it with another child. I just
wonder how we can really end up with
 traverse A->B->C because we do set B->D then set A->B when doing set
list A->B->D

Vincent




>
> Put another way, even if all of these callers used rcu_read_lock, there
> would still be a need to ensure that the parent's h_load_next doesn't
> point to a sched entity that is free'd once the RCU read-side critical
> section is exited, because the child is getting free'd and not the
> parent.  The (freed) child is still discoverable from the parent's
> h_load_next after the critical section because the delete code does not
> clear h_load_next and order that write before the free.
>
> -K

