Return-Path: <linux-tip-commits+bounces-6374-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32812B35053
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Aug 2025 02:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F571A86AD9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Aug 2025 00:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA9252904;
	Tue, 26 Aug 2025 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIbJhtSE"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E820C00C
	for <linux-tip-commits@vger.kernel.org>; Tue, 26 Aug 2025 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168692; cv=none; b=GFS2mMblF8TFPzk8QlPg0mQGQanpUDPHSnLAkpoL5cpi1LdKg5p07MJ7JPuXuSL2cROd20d4NQxowyHvjoYGBBGv9YMwZEOz1IDy0OnsWv+/IneduMSY+WN/R8uvyXU4SxWf9/AZY/GHiRy2hFdjcZMTLiRFqIr+qMdWxTXFR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168692; c=relaxed/simple;
	bh=F8O4uuGyc45cL0cysumSaSMgLtUGTGrex1L3O0+8uwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e2RhZO2nfhh2il4XuCwQvR2TtTVBFs5TOjltFq83oCaUA29eNZw5gFg2NesgO9mCS7kdNVjH98jZk46pXrK9qB+KunjuvUnUk1WOEBKjH3MtF2ZL0RMtD/tlHL8rr0z2eH2avCKhsFEPsjEPtYRypUdfewPLuoiakQHPscpwr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIbJhtSE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581ce13aso92001175ad.2
        for <linux-tip-commits@vger.kernel.org>; Mon, 25 Aug 2025 17:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756168690; x=1756773490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ja19CII3soTCgdFZTDoPMsFNvClcQAgJ1x0OG5AuLw=;
        b=uIbJhtSEx7NnQe81F3u3dNOX3SSkDJWjh2sl214D4NREkcqzjuxeviGGzeSf8U2+DF
         xfwOUS3Xd+y4/pJ4s2JAchgCKursNFtswR1/cb6+h0+FQRrc0EdFZerZd4T1ia3OdvTD
         wSR8Vz5xjIYS1lkgaX3thp1Xr6r/gb/FSlXQkgQ2nY5m0DoEZHCKlg4Zh7lIq966XSG/
         PtoMN3gHcJZjXqzvQgJiYmFfw/8YPBLewwBQE1bvzXj1nwEziV/2sbBHwKo3ws2rWctU
         vcRvJYEnbJfUmrI388dNlj/DCEDiJquduJalFpkZjkWf+tVu8IkKzxwD6jubegNWtupp
         BzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756168690; x=1756773490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ja19CII3soTCgdFZTDoPMsFNvClcQAgJ1x0OG5AuLw=;
        b=nVYJqMWQVb/lmNQWSTVJU5HbnE9ENVmPiuTSlmeKbCZQnCfuHoIPuliH3vieo1cw55
         Za71IKfGhPkGWtIYSWlqGpiZIEYYYbrjPu9M+mddg2LXkA7tXdg5u/kSG0Z6Fj/gZP/E
         /eu2pBOMlC9pql8XuUQ0WfzGH8oYE1TfddZVj2LOOIR01x+trLelENv2/zFqh2wCp9e1
         19wnHe4Kswix3SRBrDI2oG8C1JG5eOvreGiEyLlx2NSlvOzTHtTdm/2vif8G0C2jHso0
         kM7TqWR/DF/vCpOgwqkhBg0vRJbbvmC899OlhpnkaFp4GIZRD/IGjeOEtnpujQviB2rb
         p7eQ==
X-Gm-Message-State: AOJu0YyZ32EQ/MMxFjaH3i3jsKAav8iNLy/pvDyssApOOdgCJ4YP2qSR
	+Q+j0xE0QtwA8OPDxoOR2TnwLo3xIQWXLic1PDqOfHcSDyCUSqjtfaSF0JmUJ3RlNazQ7kzKCZB
	n8t3i7g==
X-Google-Smtp-Source: AGHT+IETJeR6nD3PSgpec9/wZ7wI/Qckb2cpn8I3+Z9UM8W9OjG4XLxXewOAM+UsSAlFRp/8SbfP/K1pUa0=
X-Received: from pjka22.prod.google.com ([2002:a17:90a:6d96:b0:325:3ada:baa0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0c:b0:240:6406:c471
 with SMTP id d9443c01a7336-2462ee0b897mr181336805ad.10.1756168689912; Mon, 25
 Aug 2025 17:38:09 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:38:08 -0700
In-Reply-To: <aJ_vEP2EHj6l0xRT@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710110011.384614-3-bigeasy@linutronix.de>
 <175225881640.406.2875698205071601878.tip-bot2@tip-bot2> <aJ_vEP2EHj6l0xRT@google.com>
Message-ID: <aK0B8IYKIH1IHyDj@google.com>
Subject: Re: [tip: locking/futex] futex: Use RCU-based per-CPU reference
 counting instead of rcuref_t
From: Sean Christopherson <seanjc@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 15, 2025, Sean Christopherson wrote:
> On Fri, Jul 11, 2025, tip-bot2 for Peter Zijlstra wrote:
> > The following commit has been merged into the locking/futex branch of tip:
> > 
> > Commit-ID:     56180dd20c19e5b0fa34822997a9ac66b517e7b3
> > Gitweb:        https://git.kernel.org/tip/56180dd20c19e5b0fa34822997a9ac66b517e7b3
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Thu, 10 Jul 2025 13:00:07 +02:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Fri, 11 Jul 2025 16:02:00 +02:00
> > 
> > futex: Use RCU-based per-CPU reference counting instead of rcuref_t
> > 
> > The use of rcuref_t for reference counting introduces a performance bottleneck
> > when accessed concurrently by multiple threads during futex operations.
> > 
> > Replace rcuref_t with special crafted per-CPU reference counters. The
> > lifetime logic remains the same.
> > 
> > The newly allocate private hash starts in FR_PERCPU state. In this state, each
> > futex operation that requires the private hash uses a per-CPU counter (an
> > unsigned int) for incrementing or decrementing the reference count.
> > 
> > When the private hash is about to be replaced, the per-CPU counters are
> > migrated to a atomic_t counter mm_struct::futex_atomic.
> > The migration process:
> > - Waiting for one RCU grace period to ensure all users observe the
> >   current private hash. This can be skipped if a grace period elapsed
> >   since the private hash was assigned.
> > 
> > - futex_private_hash::state is set to FR_ATOMIC, forcing all users to
> >   use mm_struct::futex_atomic for reference counting.
> > 
> > - After a RCU grace period, all users are guaranteed to be using the
> >   atomic counter. The per-CPU counters can now be summed up and added to
> >   the atomic_t counter. If the resulting count is zero, the hash can be
> >   safely replaced. Otherwise, active users still hold a valid reference.
> > 
> > - Once the atomic reference count drops to zero, the next futex
> >   operation will switch to the new private hash.
> > 
> > call_rcu_hurry() is used to speed up transition which otherwise might be
> > delay with RCU_LAZY. There is nothing wrong with using call_rcu(). The
> > side effects would be that on auto scaling the new hash is used later
> > and the SET_SLOTS prctl() will block longer.
> > 
> > [bigeasy: commit description + mm get/ put_async]
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lore.kernel.org/r/20250710110011.384614-3-bigeasy@linutronix.de
> > ---
> 
> This is causing explosions on my test systems, in code that doesn't obviously
> have anything to do with futex.

Closing the loop, this turned out to be a KVM bug[*].  Why the futex changes
exposed the bug and caused explosions, I have no idea, but nothing suggests that
this patch is buggy.

[*] https://lore.kernel.org/all/20250825160406.ZVcVPStz@linutronix.de


> The most common symptom is a #GP on this code in try_to_wake_up():
> 
> 		/* Link @node into the waitqueue. */
> 		WRITE_ONCE(prev->next, node);
> 
> although on systems with 5-level paging I _think_ it just manifests as hard
> hanges (I assume because prev->next is corrupted, but is still canonical with
> LA57?  But that's a wild guess).
> 
> The failure always occurs when userspace writes /sys/module/kvm/parameters/nx_huge_pages,
> but I don't think there's anything KVM specific about the issue.  Simply writing
> the param doesn't explode, the problem only arises when I'm running tests in
> parallel (but then failure is almost immediate), so presumably there's a task
> migration angle or something?
> 
> Manually disabling CONFIG_FUTEX_PRIVATE_HASH makes the problem go away, and
> running with CONFIG_FUTEX_PRIVATE_HASH=y prior to this rework is also fine.  So
> it appears that the problem is specifically in the new code.
> 
> I can provide more info as needed next week.
> 
> Oops: general protection fault, probably for non-canonical address 0xff0e899fa1566052: 0000 [#1] SMP

...

> Call Trace:
>  <TASK>
>  _raw_spin_lock_irqsave+0x50/0x60
>  try_to_wake_up+0x4f/0x5d0
>  set_nx_huge_pages+0xe4/0x1c0 [kvm]
>  param_attr_store+0x89/0xf0
>  module_attr_store+0x1e/0x30
>  kernfs_fop_write_iter+0xe4/0x160
>  vfs_write+0x2cb/0x420
>  ksys_write+0x7f/0xf0
>  do_syscall_64+0x6f/0x1f0
>  ? arch_exit_to_user_mode_prepare+0x9/0x50
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53

