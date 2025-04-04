Return-Path: <linux-tip-commits+bounces-4668-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F3AA7C0EF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD857189F2A9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886A1E5B74;
	Fri,  4 Apr 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j74AMQRg"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63451DF962;
	Fri,  4 Apr 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781795; cv=none; b=MoWxjE1QeGhfBmefxWkfVX25q94PxC6zk7FUMXfJuOcIJx9OrBLPVqGSKc86DDqbTPqKtwBF6d+NScziZIg+6fFoQCXH5WARYo5P8y0pP8rD30DNhtlW/nSr4PrmnH5Spvua0SZ2d4IVkCWg5n5u+k/p8t0KR+koqBIULabKMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781795; c=relaxed/simple;
	bh=m4LCpakrwz86U21T1J3A9DSHDf8q+L/BJbl7HOX/PI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9KOO3czw43iedvaLYKVKQkwmIFRnwFw9i7aqB2d0oCa2Bwo/MZp9BaxXo3ZdH6G0OLQFFVzk5uYm60x0kr0aslgrrDxDqY0pJ4LpplrQcqfPz97xJC0sXtzx+qmP21Hfh/AgkJkP36KSkqgVOYpBmSuBH5x1FoyQNas2jJYz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j74AMQRg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736c1138ae5so2146389b3a.3;
        Fri, 04 Apr 2025 08:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743781792; x=1744386592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP84vi9S/CO3pARMt8AsumexblRaEcsvg6qxFTYHyzU=;
        b=j74AMQRgDit1YzGweT2uu4vHM7tHkKbbDV0lrYL22t1VNgE0dNGtApHGs+sr9MKAMo
         uNXPV9PFEXtWQux+ZmsO+ECUoQG+odf/Y0+s/VsLYyOKGiBAXM92sZgbjW4kCF+zi7AO
         eS7Jnw5lJAo3Z9ib38Y2IKPjd2B5GfzPWH8A0aiq1CSiW050gGdrE1xGPZs8GDRYG8E2
         gIuvQmmlqr/mkZg+D4Tqw9a94mZ81ETrfJwW2eGaZhg3K6aTwqqnPYW0KY/Yh3xImQNt
         Vw5jkQ1X8LnaxPm4N51tXVCgePw+V1hWREkb3/tX5vANgXSN61BuJxBaFS5uu90efOXw
         rtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743781792; x=1744386592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP84vi9S/CO3pARMt8AsumexblRaEcsvg6qxFTYHyzU=;
        b=s9lRUW1CLb+8EG1Xpd/PjykkP8Rk7PJeTIwm0+kfk+fFslbeDKSFqTDE9sQxr1ZoZQ
         WbVxx+OE2JymDKHz4Tr3J29RPrAtJzctLAshJO+i1qkGpdweBTT/h++DjByvc1o6ETg4
         X+u6k1UstNv1qMCf/MTTwExQAdxt6KfEvRPm0Ah0Sp7OhBB3/3Q1IxiczGk6gqMmN8O8
         8ueDi7MZV0UPOE9MWPyGT2qCHfq5IkYTXXbFhS5besSx1llcNInywXY5b+KAIawM9Cwm
         rge7b9Fl4cvkY2B2jPbAmRAhtYJpUNBnMc1ihOnu9xPECt2HqP7pVpFy/ExpKP4UbBp4
         M2jA==
X-Forwarded-Encrypted: i=1; AJvYcCW1gTJBqxdqkJSuo1CJT+NDXnOVWxtzzVjKqeyDBXQw5xWfj1LOuHRKFNMpnRfAQ6HQKifUJA/GjzRthCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kXSHJMhyam/6ZyXwOpmCqaPmsG4CaTMMpIRK3UV5ph0CerO3
	h1qPsSVEzmk0NLRuHmzf/Nuz2iznPqKKDnzPPModCQ03vcI/G8y+GgO11iE7GCLknAJBpTyDJ+Y
	AfGrBKz90+0gxvS3WFX0A4qKnFlY=
X-Gm-Gg: ASbGncvaPdCrnc6qbk5BerZiwtPy+at6yrCuNAuXPF0Pv+kiFs24nF7XxNX0M4spoxO
	tjOOG4U8XLbyTBVQ96SdkyecchG9mojlWugpaFhqbUoFStBYY4rckC7RzJ55WwTVW29nK7UaWct
	BGJql0osIRuFqVZOkH4DMnzISiDmS3q4x6NNrKDTKLTrY3MKFRiHmS
X-Google-Smtp-Source: AGHT+IEGSKaLUOWXoq7rVkkc1aMtN18O+AIOmTA0joIqPgtrP+lM3ynTb5VE7B3UzbDJr+PTPdU76v/awPgbgUIVPA0=
X-Received: by 2002:a05:6a00:a89:b0:737:e73:f64b with SMTP id
 d2e1a72fcca58-739e48c6f91mr4748744b3a.1.1743781791914; Fri, 04 Apr 2025
 08:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402180925.90914-1-andrii@kernel.org> <174375584977.31282.8985910498663747932.tip-bot2@tip-bot2>
In-Reply-To: <174375584977.31282.8985910498663747932.tip-bot2@tip-bot2>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 08:49:39 -0700
X-Gm-Features: AQ5f1Jqfd2hG6YA6tRwgUlmaICWmxlM7J06z-rwLADpQzMcIV0kKb2AsCOqMnwI
Message-ID: <CAEf4BzavW0GpSU4aT_kXF_rjyrEAoYfW8Ld8LzsL1boGo=xa5g@mail.gmail.com>
Subject: Re: [tip: sched/core] sched/tracepoints: Move and extend the
 sched_process_exit() tracepoint
To: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-tip-commits@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 1:37=E2=80=AFAM tip-bot2 for Andrii Nakryiko
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the sched/core branch of tip:
>
> Commit-ID:     3e816361e94a0e79b1aabf44abec552e9698b196
> Gitweb:        https://git.kernel.org/tip/3e816361e94a0e79b1aabf44abec552=
e9698b196
> Author:        Andrii Nakryiko <andrii@kernel.org>
> AuthorDate:    Wed, 02 Apr 2025 11:09:25 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 04 Apr 2025 10:30:19 +02:00
>
> sched/tracepoints: Move and extend the sched_process_exit() tracepoint
>
> It is useful to be able to access current->mm at task exit to, say,
> record a bunch of VMA information right before the task exits (e.g., for
> stack symbolization reasons when dealing with short-lived processes that
> exit in the middle of profiling session). Currently,
> trace_sched_process_exit() is triggered after exit_mm() which resets
> current->mm to NULL making this tracepoint unsuitable for inspecting
> and recording task's mm_struct-related data when tracing process
> lifetimes.
>
> There is a particularly suitable place, though, right after
> taskstats_exit() is called, but before we do exit_mm() and other
> exit_*() resource teardowns. taskstats performs a similar kind of
> accounting that some applications do with BPF, and so co-locating them
> seems like a good fit. So that's where trace_sched_process_exit() is
> moved with this patch.
>
> Also, existing trace_sched_process_exit() tracepoint is notoriously
> missing `group_dead` flag that is certainly useful in practice and some
> of our production applications have to work around this. So plumb
> `group_dead` through while at it, to have a richer and more complete
> tracepoint.
>
> Note that we can't use sched_process_template anymore, and so we use
> TRACE_EVENT()-based tracepoint definition. But all the field names and
> order, as well as assign and output logic remain intact. We just add one
> extra field at the end in backwards-compatible way.
>
> Document the dependency to sched_process_template anyway.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Adding Andrew.

Seems like my patch was applied both by Andrew ([0], [1]) and Ingo.
Andew, would it be possible to drop those from your tree and keep the
one in Ingo's tip/sched/core? Thanks!

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/=
patches/exit-move-and-extend-sched_process_exit-tracepoint.patch
  [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/=
patches/exit-move-and-extend-sched_process_exit-tracepoint-fix.patch

> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20250402180925.90914-1-andrii@kernel.org
> ---
>  include/trace/events/sched.h | 34 ++++++++++++++++++++++++++++++----
>  kernel/exit.c                |  2 +-
>  2 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 8994e97..3bec9fb 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -326,11 +326,37 @@ DEFINE_EVENT(sched_process_template, sched_process_=
free,
>              TP_ARGS(p));
>
>  /*
> - * Tracepoint for a task exiting:
> + * Tracepoint for a task exiting.
> + * Note, it's a superset of sched_process_template and should be kept
> + * compatible as much as possible. sched_process_exits has an extra
> + * `group_dead` argument, so sched_process_template can't be used,
> + * unfortunately, just like sched_migrate_task above.
>   */
> -DEFINE_EVENT(sched_process_template, sched_process_exit,
> -            TP_PROTO(struct task_struct *p),
> -            TP_ARGS(p));
> +TRACE_EVENT(sched_process_exit,
> +
> +       TP_PROTO(struct task_struct *p, bool group_dead),
> +
> +       TP_ARGS(p, group_dead),
> +
> +       TP_STRUCT__entry(
> +               __array(        char,   comm,   TASK_COMM_LEN   )
> +               __field(        pid_t,  pid                     )
> +               __field(        int,    prio                    )
> +               __field(        bool,   group_dead              )
> +       ),
> +
> +       TP_fast_assign(
> +               memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
> +               __entry->pid            =3D p->pid;
> +               __entry->prio           =3D p->prio; /* XXX SCHED_DEADLIN=
E */
> +               __entry->group_dead     =3D group_dead;
> +       ),
> +
> +       TP_printk("comm=3D%s pid=3D%d prio=3D%d group_dead=3D%s",
> +                 __entry->comm, __entry->pid, __entry->prio,
> +                 __entry->group_dead ? "true" : "false"
> +       )
> +);
>
>  /*
>   * Tracepoint for waiting on task to unschedule:
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 1b51dc0..f1db86d 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -936,12 +936,12 @@ void __noreturn do_exit(long code)
>
>         tsk->exit_code =3D code;
>         taskstats_exit(tsk, group_dead);
> +       trace_sched_process_exit(tsk, group_dead);
>
>         exit_mm();
>
>         if (group_dead)
>                 acct_process();
> -       trace_sched_process_exit(tsk);
>
>         exit_sem(tsk);
>         exit_shm(tsk);

