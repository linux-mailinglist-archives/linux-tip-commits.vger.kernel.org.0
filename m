Return-Path: <linux-tip-commits+bounces-4520-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F508A6ECE1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472031897DE1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89B1E5B73;
	Tue, 25 Mar 2025 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYADZshQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DF254AF6;
	Tue, 25 Mar 2025 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895446; cv=none; b=dJ5bEYDh4CzxgNfzo/jwGl4ExhYtbZufD/apAkeDyLgZjfZAFAJB5NyFongmiULCL7zUN0FOSIa84aL+/9dx6kasJVMv4XP8RfwE/76zc1Lu9ZjkFo0CVm3dLblL02GrDZtB8klem3Kb6V+3tNrH5y0T/muixxvYZTH5OItb4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895446; c=relaxed/simple;
	bh=AHwEEOsPxfM28gdYXP8G0pyWy24gA8HYOlRvrFe1cJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmvNskeva4C66rNorYyaRvHkNnzZe5Zz9PmJwMTb2I/f0QlYpXlgS1YQITQWUXaTtgZeeQV8Osn6n44lRfBOBnL/leGg+81PYT37nOw1wcWnw7xY2EWvvv+hFeR3xXj05pvUERA975ZFuycQRuC1pUcVUk+l8r2TpFfH7jbtWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYADZshQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20655C4CEE4;
	Tue, 25 Mar 2025 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742895446;
	bh=AHwEEOsPxfM28gdYXP8G0pyWy24gA8HYOlRvrFe1cJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYADZshQds3KWyP49aKYl2eeeDvjaIMEZakGwCFaJc9hwM4uhqD4XqoN6K+7Lx0Lb
	 etHSzyBKh1r7NsSTTw2/cSYWM3CeRyyCD8qrSEYqe28W3ucYO7QDu+HxuZDESp9lKM
	 HglVtEbT/rLtmbhYNZIcu0IaRdB12sUAlbRgFeJGngA4hK9qqMssVx0vr3U89M2ESv
	 6xwTjX0vUp4/9qonvsY7jyPHzILZtguYA2cYhH8MUPNkx4ZyLY+hrEH5goAjP9JFNu
	 JS55suwooAVuyFC2lq58IMWkvDG88uDhWRh3xXsBwtoUpt9u0kYf9Y4KEaX2jwVFCQ
	 yAJnQszUBg2sA==
Date: Tue, 25 Mar 2025 10:37:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/debug: Change SCHED_WARN_ON() to
 WARN_ON_ONCE()
Message-ID: <Z-J5UEFwM3gh6VXR@gmail.com>
References: <20250317104257.3496611-2-mingo@kernel.org>
 <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324115955.GF14944@noisy.programming.kicks-ass.net>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Mar 20, 2025 at 09:00:05AM -0000, tip-bot2 for Ingo Molnar wrote:
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     f7d2728cc032a23fccb5ecde69793a38eb30ba5c
> > Gitweb:        https://git.kernel.org/tip/f7d2728cc032a23fccb5ecde69793a38eb30ba5c
> > Author:        Ingo Molnar <mingo@kernel.org>
> > AuthorDate:    Mon, 17 Mar 2025 11:42:52 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Wed, 19 Mar 2025 22:20:53 +01:00
> > 
> > sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()
> > 
> > The scheduler has this special SCHED_WARN() facility that
> > depends on CONFIG_SCHED_DEBUG.
> > 
> > Since CONFIG_SCHED_DEBUG is getting removed, convert
> > SCHED_WARN() to WARN_ON_ONCE().
> > 
> > Note that the warning output isn't 100% equivalent:
> > 
> >    #define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)
> > 
> > Because SCHED_WARN_ON() would output the 'x' condition
> > as well, while WARN_ONCE() will only show a backtrace.
> > 
> > Hopefully these are rare enough to not really matter.
> > 
> > If it does, we should probably introduce a new WARN_ON()
> > variant that outputs the condition in stringified form,
> > or improve WARN_ON() itself.
> 
> So those strings really were useful, trouble is WARN_ONCE() generates
> utter crap code compared to WARN_ON_ONCE(), but since SCHED_DEBUG that
> doesn't really matter.

Why wouldn't it matter? CONFIG_SCHED_DEBUG was turned on for 99.9999% 
of Linux users, ie. we generated crap code for most of our users.

And as a side effect of using the standard WARN_ON_ONCE() primitive we 
now generate better code, at the expense of harder to interpret debug 
output, right?

Ie. CONFIG_SCHED_DEBUG has obfuscated crappy code generation under the 
"it's only debugging code" pretense, right?

> Also, last time I measured, there was a measurable performance
> difference between SCHED_DEBUG=n and SCHED_DEBUG=y.

Which 99.9999% of Linux users are affected by. The config option 
basically did nothing for them but hide this overhead...

Thanks,

	Ingo

