Return-Path: <linux-tip-commits+bounces-4554-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E84EA70D82
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 00:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A15188E6A9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69F018EB0;
	Tue, 25 Mar 2025 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MW6ogeaH"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5525484F
	for <linux-tip-commits@vger.kernel.org>; Tue, 25 Mar 2025 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944397; cv=none; b=jeLXFCacu9A2jssmMkobSBZPp0NYX5fvOf+va2qfn+76I0L6rA9pZ2PHaAWIVhVecP+0tWBdVCLf0Pn3u0WcF1yaPwAQ1OEaWGEUW1fHJR2O9hn0K3NMXl4mP7ZW6ajnKRJsEXa8mmG/Z3FOGPxTWzrN599fV1cw3HAfjl3gX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944397; c=relaxed/simple;
	bh=jw3maACCO3f6vt9Qr0IksUHDBNePsVPYv0eL53Q5Uko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTqLTUxc7BYbMDmvBEFiL+ELlwWfi8i3hyfky29lvo+0Dp7iQTD5iNbCMXMD5QyjtGKkk4L8HdiWeH9D0epjqPeHv+to+1abf/hXcbVTJpUfaKwQ6FAVp5s7APb/FTs3zbJzw33NK9lxPDX+nT1vqCriUKgj+Cz+kUPADuKxUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MW6ogeaH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac34257295dso1274499066b.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Mar 2025 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742944393; x=1743549193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3h0xRoLxiN1v7pMNtH0qapseB+kIL16c87ibP89wiw=;
        b=MW6ogeaHH2+6wLzjPAeihKuIAGkR7V5Kc6O8NJTk83CJwRJ907RZ7SsVt1VvybXg9x
         4pMQuZSa1mjYM/PDzbOBA3PqsHN8NH0k7zJsw5xEUY/nZW8cSV0p3+fp4Rz9pbOIQNgK
         oq88JODWUGWDRvBGFKn9ZaiDfli1hceagUdFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742944393; x=1743549193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3h0xRoLxiN1v7pMNtH0qapseB+kIL16c87ibP89wiw=;
        b=aRLqA2giXH4MRtkD/Lvz8BY2JCo6Qi88PSQgswbeWqCi4gcGAog11DSbmV88GIdpJb
         wh92U+Vmq2ilf34IEjrdzOKPYoGq0GjC8PXJM2cOP237EXTIkysTKX8OBB66t77kuNi3
         HI+GTAJP5dXzFn/5J+zw5W1L1gdR3EBb2+JguxUf6rOnGY6CbYXfdBLwtSXuoVc60CpA
         yjhtNK//yCV7bq1GpKN/WQyw7/Nj8OZD1eyeETC8Qc33E6H4UKcWBOwdyo9wUmtqdLAh
         6ImVqId7CB4C7wLKvYbRMkyoZdyt/q9dkcE6D0pMVZkAphYo+NgMQz/tGS5/iY4+Udoo
         HQJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh1Guew2Kbl+ldVrTKY6E+yZTPAMCWzWy+WfuPW4Rs6xDYQN0WZvEcNLnF9wPiX6Jx8FkoAXvu6kl48xUMzDD2Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMo12bkOXwQrtR8UD9hp5FldVAS0xvoqhgVF1oGbEsxx4aZS2b
	SkfyeZQgz5+px+l1RKaIhRilmjXXSXojVt3jeJ5eKNpIlKCM7xh4FQVjBYecJhJaGQeJCJ6OpcL
	7hiUdLA==
X-Gm-Gg: ASbGncvW1GbjKPngqlh91ea8bhZNAijBH7Jeo+PLo1B0kszAzJCyKbzOwyAvTyLWTjQ
	c/X/BajMCGXFOibfXHjPNu6jJQxR4EG8Wy0FFL9NvdO0oK4uClbhy9M5o4DQA7QBJ8QhhphWuAb
	2Fkiwrdavwsh8XtoXWTIF/qO975YmdwboOU4CnZNhMOBHosgHAQI/0FEv0YoJJ3av6whqTlgcgM
	mWSHcv9TQkj+dJKEo3qnktk5BY5jT+RxKmHJ9wPdBNZv9jxlZJQVXFWlECB5WIoYLyTxdv4nK1N
	ViNr6dIxpGGjxYkGFUtP0RtgL4JdnPw8c9Z64EqBNiLBxrJ7kLtBlg0hX9ovDT6y9YPOD7q3AP3
	ZbPjK6s0cAiBrTql59XA=
X-Google-Smtp-Source: AGHT+IG6Akxv6A1pAaGo0IREaUmzgv4aY1Y2wMbXVv/iE6Qb5vuuF+YqIwDKLzC6NYwVKCq7ZehBSQ==
X-Received: by 2002:a17:907:6ea2:b0:ac2:6910:a12f with SMTP id a640c23a62f3a-ac3f251a403mr1698997566b.46.1742944393405;
        Tue, 25 Mar 2025 16:13:13 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd4798dsm919151766b.161.2025.03.25.16.13.12
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 16:13:12 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac34257295dso1274494066b.2
        for <linux-tip-commits@vger.kernel.org>; Tue, 25 Mar 2025 16:13:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4ZR+9eiQt3+B4vc2yRqUM5yeW/9VvUg2I98rOaM9J8HWi/VlPIs01dWt3mf9zun++iCzCJH4OI0zRpg78donrSA==@vger.kernel.org
X-Received: by 2002:a17:907:9728:b0:ac3:26ff:11a0 with SMTP id
 a640c23a62f3a-ac3f251ac63mr2074660766b.38.1742944391848; Tue, 25 Mar 2025
 16:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317104257.3496611-2-mingo@kernel.org> <174246120542.14745.16936293992221722909.tip-bot2@tip-bot2>
 <20250324115955.GF14944@noisy.programming.kicks-ass.net> <Z-J5UEFwM3gh6VXR@gmail.com>
 <Z-KRD3ODxT9f8Yjw@gmail.com> <20250325123625.GM36322@noisy.programming.kicks-ass.net>
 <CAHk-=wg_BRnCs8o5vEjK_zDuc0KJ-z9bvq5845jKv+7UduS4hQ@mail.gmail.com> <Z-MxULQtc--KoKMW@gmail.com>
In-Reply-To: <Z-MxULQtc--KoKMW@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 16:12:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMu5iGZ2ifBqjzV4a993D13OnDvfbtYe6jgPP8cZnAGQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr72i2YXbGGJdC978hKkzVdmQ4LG3orQqVMCJwAlQF0vF7KbLFr4RRoHnc
Message-ID: <CAHk-=wjMu5iGZ2ifBqjzV4a993D13OnDvfbtYe6jgPP8cZnAGQ@mail.gmail.com>
Subject: Re: [PATCH] bug: Add the condition string to the CONFIG_DEBUG_BUGVERBOSE=y
 output
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 15:42, Ingo Molnar <mingo@kernel.org> wrote:
>
> So something like the patch below?
> [...]
> After:
>
>   WARNING: CPU: 0 PID: 0 at [ptr == 0 && 1] kernel/sched/core.c:8511 sched_init+0x20/0x410
>                             ^^^^^^^^^^^^^^^

Hmm. Is that the prettiest output ever? No. But it does seem workable,
and the patch is simple.

And I think the added condition string is useful, in that I often end
up looking up warnings that other people report and where the line
numbers have changed enough that it's not immediately obvious exactly
which warning it is. Not only does it disambiguate which warning it
is, it would probably often would obviate having to look it up
entirely because the warning message is now more useful.

So I think I like it. Let's see how it works in practice.

(I actually think the "CPU: 0 PID: 0" is likely the least useful part
of that warning string, and maybe *that* should be moved away and make
things a bit more legible, but I think that discussion might as well
be part of that "Let's see how it works")

            Linus

