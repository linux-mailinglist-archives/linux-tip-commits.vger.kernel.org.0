Return-Path: <linux-tip-commits+bounces-4538-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776F2A7087F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 18:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FEF3B8EF3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA4263F28;
	Tue, 25 Mar 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gb2SnpTB"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D461A5B90
	for <linux-tip-commits@vger.kernel.org>; Tue, 25 Mar 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924952; cv=none; b=hh5+4V6zOZV3E6va4rxo+6jxje3vZInoA7uFtt1brpYPAutQgOvzBQIksKn9S0faR+NrkOVrQP95aj0u2TBImv7iAct1noHfIhN1+qrCk0fXutKB/cJGrUYuUMxgMwmQ7Mpw6eizBtYutDPRZ2aVZ/vGY0aa48lk/ndl1I7dLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924952; c=relaxed/simple;
	bh=5lf9EyK9tb9PQqHAZDOiGSp/8OmQ860G+KzjdCsaVYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgZ44v16BrkaJhXUg/JUGA2FFmvcRQeQNwtakwzyl2FK1AoKxaGlJu4jvzO4xGFHAnNNxDYRubtmJidkHWmSNYEAZTySIbGwTClPeIB9vnGQQaaZBxUqzRZbDZSQV/hKUS4+N9qHBOs4gXB+ns0YJMR8YpQZjqd1kUL+Hta+9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gb2SnpTB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2c663a3daso366571366b.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Mar 2025 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742924948; x=1743529748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6P+BC0MhYFh9Fc34++UOutlTwR2W5Ljjjnd/jFWs0/U=;
        b=gb2SnpTBHe/I0js/rXLyu5fEXP98Vbx0qTn2+hC3qyW1MbT79az1+zOq31MOU1b/9w
         wZYfXvQjFAsce6XZf+QfWTMAragDulj8WVbENtfloP0sBlgb4dtyVEYkwsax5gJYG+Xm
         vg2GKFTIAFbHHh4cEYfo54bYRS1OWVQVxOh4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742924948; x=1743529748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P+BC0MhYFh9Fc34++UOutlTwR2W5Ljjjnd/jFWs0/U=;
        b=TGWnPSx15K7KeH9i0z3E1gSUFO1kbYRn4U6vF4l/25XeZVcD9PtYrxsue5sNUiS4og
         L7/ON0jM/USfpPahwMl3lNhjfN/CPLF561aYMiy1V+w10vRaTq625bT9p4qtrKeB+036
         MGkmKvP9oxzU7KAeIHNMH6GhSWMNukjwZ6jvJpJmCdWXpY1EN4i+6o9UGnXEiSVCiaUa
         9kNiKkXS/z7s0jCToSsGAyAqa3K5eU3NDOaym/q+vLd2uh2V+LsQVOq23pzekWTFZ2wA
         Ne9LeiYM0w1zOv0tg/VGf/OQZs3KQ2alChDRBS8ENJ5UA5XjKOcETV44RU10hPtL3QtO
         jdUA==
X-Forwarded-Encrypted: i=1; AJvYcCWqYyY320Pwtbbtpqa+ZVeWmSXmcQ3fWwjB1Y/mxiB+/yrHw86iTK6lnbDtmZ05AUVNR1LWz04pdEzy1jkh0iIGbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSTx/I+woMkUM1h/Ej1IOsAh9mHgBmfI4poeUNJovQbU+pB8B5
	17GOTyBeS3PiNM+Vy4ywse6Q4w8DGwvnVnS6LDemi1Xxzz7r/qmLJ7XuHdwoqiJcPjahJXWCIma
	zoyg=
X-Gm-Gg: ASbGnct3obSxVF1wjk8BwWlMFEYlgkgmoeO7/z/j8+LsFIHAgdBZBkLKgY0856CvIJW
	+qigpsb8lfs3Blz4ZCGSIGypvrlFsuMiuRZKmXAWjfMh0pzwaMcf2JVFKH0tOxJiYNHVLk72ahC
	2YG2c1nlxUc0Du0nEFqkWo7upQohDIcnF8jziclMQJX+CyvgR6HjnmPu9ROZv33CnxlS97PNnJl
	rt2FLKWU5hjwFX02IRYLaIDCCx+o0Nkipcnkt92sWgBqqvQ1myP72gJXahyzuGnWB4FhbwgtHMD
	AS2AW9N180sy6ru437PSotZJl+BtjjKhVjckoMN6XUGGtYZ8KpNWWoz4/PGZRRyNJ1bnW4r46Jr
	b0PM4BWAP8kbJazA4EwI=
X-Google-Smtp-Source: AGHT+IFrK9HDN1Hv373txxoZXij/88SnFEtok+AyqjWBPWwj8pFG3qCL6umqSk/6dh4wJ1Dy6K8Wmg==
X-Received: by 2002:a17:907:da0:b0:abf:6cc9:7ef2 with SMTP id a640c23a62f3a-ac3f24d5d6bmr1892004466b.42.1742924948413;
        Tue, 25 Mar 2025 10:49:08 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb64945sm901809566b.95.2025.03.25.10.49.05
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 10:49:05 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac339f53df9so90483666b.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Mar 2025 10:49:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPxhqcrwrMpmqkCFQ7WyIvVXksuijjn7/dLUJt2G4dNa3rtTmFf3nUqDRrpB/lKZq7vUl7FVRkUPvexcx7MaelWg==@vger.kernel.org
X-Received: by 2002:a17:907:9707:b0:ac3:9587:f2ac with SMTP id
 a640c23a62f3a-ac3f2293764mr1697642366b.33.1742924945447; Tue, 25 Mar 2025
 10:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317104257.3496611-2-mingo@kernel.org> <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net> <Z-J5UEFwM3gh6VXR@gmail.com>
 <Z-KRD3ODxT9f8Yjw@gmail.com> <20250325123625.GM36322@noisy.programming.kicks-ass.net>
In-Reply-To: <20250325123625.GM36322@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 10:48:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com>
X-Gm-Features: AQ5f1JotVBul2ZkcrgvaYiVPsvTjoSUOm9EMep0EghGICtNe3Dzg71mQtdusIkk
Message-ID: <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com>
Subject: Re: [PATCH] bug: Introduce CONFIG_DEBUG_BUGVERBOSE_EXTRA=y to also
 log warning conditions
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

 On Tue, 25 Mar 2025 at 05:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> The problem with WARN() is that it is a format string, which must be
> filled out in situ. Resulting in calls to snprintf() and arguments and
> whatnot.

A fair number of warnings do want the format string, so that you can
print out more information about what went wrong if the warning
triggered.

That said, I do think that the "just give a fixed string that is the
warning condition" is probably the right thing 90% of the time, and is
the much simpler interface both to use and causes much less code
(exactly because it's just a single hardcoded string at compile time).

So I think we end up wanting both.

But I *don't* like Ingo's suggestion of DEBUG_BUGVERBOSE_EXTRA,
because it does that "both" by making the simple case complicated.

How about going a different route instead? Right now we have that
CONFIG_DEBUG_BUGVERBOSE thing which adds the file name and line number
information. That has been very good.

But maybe that should be extended to also always take the compile-time
'#condition' string?

So then all warnings would have the warning condition string (assuming
you end up enabling DEBUG_BUGVERBOSE, of course, which I think
everybody pretty much does). With no extra code.

And then the _dynamic_ string - and associated code generation - would
be only for when you want to print out the actual values that caused
the warning.

Hmm?

             Linus

