Return-Path: <linux-tip-commits+bounces-3952-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF39A4EB46
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41EE19C2140
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDD5294ECF;
	Tue,  4 Mar 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dLHrQMp9"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0199F294ECC
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111343; cv=none; b=U5SXjDOyG0HJo5bNcM6rq+0eYOXEqqD/DD4+ALQkQjlCnNyf+qgl2fg79ebh/pK6g/NxNBkpPhiLhigbVZ1mhhsW1x0aQ5pnUZfLwykoqTgiOS4UatPheIFUVC5BrK4yNh2/SygbY0hopFLHZC+oddFM5Uskhue6a/pbqdMQllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111343; c=relaxed/simple;
	bh=dwlCICgBvjVCGr7BVidpNH2woY9QKhCraMbFnYt8Dzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyP5/YbCMj8R26HIYVKx+Fusv/ht0pe+AERxbY4bPCt26V9KP29mAxUMv2F0JLAXTlfUpLFTUuXtsdofHMBieOXCq0PWGKgVhhvbYfwqxmwk35FNNMLbplVdQthRi30BDZ7OEkVB+JM6a8MYgT+IOAqGB5FTLK1QPrQ2dCZg6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dLHrQMp9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-543d8badc30so6837497e87.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 10:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741111339; x=1741716139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q36U1qa7lz9QnvyXi8cj7aYNXjnZ30zhkSSKwxKgUII=;
        b=dLHrQMp9Y8RHJgxnzZZWdQ/gfS9MabNiPEU7fTvO1Y50sfQlNAXWKKM4K7YTzPJSKY
         pIXmdVeH6tKLYb32+yY24PO491HHQyPQ1/mk7SXYlSVjHZFG9zQhRo/aaznwYY4ppOig
         zZ4fY8AoNuhtKTBsgCKY1wLOUGXoxjuiAwdts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741111339; x=1741716139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q36U1qa7lz9QnvyXi8cj7aYNXjnZ30zhkSSKwxKgUII=;
        b=G3d6ZNr0jCa7SDdyS1NhbedC/8Og8zWrbCBWLivGzdmtv39u1LeFyQtQHMfYcaPuC4
         2sPj1RPakge0xds4/abWsvznPClja4z+h+9kAqPzhqZOFGkg5iAW53Sxzna3cnN7kqKy
         0H38lTqOSfC5aZfgWkMU4LOAIZNUCe+2P/Rpm2wgzRXxA2KxyVDPH7jsIJegakPSLmvn
         l9U1TmWbdq5T0Clsicyiy85knRIXfnWA6XzfhvaybPV8QJtzVU9SOuFHZMc+bccdb56l
         fryKVqljfaGgbNnE/7tigMCZIFHZboYvGVRDR/E7FUK0TNTulUyM8bJFlx6ZlvKdgcvw
         nw1A==
X-Forwarded-Encrypted: i=1; AJvYcCVTIOOS3TQeuhc4aw6eC2pEpNrlrSc7euR+MgVq6Kmjp4Gohfpf4M0c43b7UzJU773GWymns9mGXTX5LCVKhr5b7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgltUmoGghy60eorfDNeB6T0s3SpYAeIzD4BXXTlRgqW3oCht
	mAvQIDesFNaysZqZgIG5Q9X4vR1RqpCclK1h2mhU9I2jXlM2kQVKe/MEjh1I8wBdfpeIvrY3zhB
	BdT4=
X-Gm-Gg: ASbGncuFg/gYzw33F4AALW7hjsO9qtD/abrpEvE/lj61XXIyb/2fIcUwEg1ljIKMg4y
	7dfL4omRKkEtBVoHbgsCpocdM3jnhBWeJ7gl1bmHf+eP2Wmhgd+CSV+h25TCM9rluVlROzvQhx5
	2rf2qYKL/4PizTk8F+NvSjpTSS7tiQT7c/FYYwH0lUAifAyFDRhBTNOm2PivQp5R/jNJVrVWRU/
	nQy9cjR1r7dQ0MhtLr4PXoNMclyFdoaPF6vQ9RunpMWzh+B0oIw8qxZ9vtHYJumO5TbT+ROKKkq
	WXhjV7SHT7WsQZHKbXKqftibPAj5vK5Yt+wbgLzUCFxJvGjbQ4SemJXhao3jh3R16N0PnWBxI4O
	6S7JyMzhAF1SGtoTJQzY=
X-Google-Smtp-Source: AGHT+IFvdlSpVWK3hwGogt6pLSc6jn9JdJAgY8K37ood5/wbI0/PdUMCbQ3PCie7XteeKlBaLYzLMA==
X-Received: by 2002:a05:6512:3e0c:b0:545:8f7:8597 with SMTP id 2adb3069b0e04-5497d337a0cmr41618e87.16.1741111338791;
        Tue, 04 Mar 2025 10:02:18 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54958f1d3f0sm1119728e87.20.2025.03.04.10.02.14
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:02:16 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54954fa61c9so5175305e87.1
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 10:02:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpn5BjfRxjasGMtBygY9MdPYJyFMz+kQ6tu0dhuZaUS3TMs14fDxksJ9wSK/Jvjt8s9PTjhi2XqlPwq6sHbD26lw==@vger.kernel.org
X-Received: by 2002:a05:6512:b05:b0:549:78bd:6b8d with SMTP id
 2adb3069b0e04-5497d37a981mr30735e87.39.1741111334440; Tue, 04 Mar 2025
 10:02:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
In-Reply-To: <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:01:58 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
X-Gm-Features: AQ5f1Jpg7NumWYmjX4cZrIeXlN6G1CJCazg40Tn5gbT0_0X-Apg_WOnDgtXua6I
Message-ID: <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 07:51, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Put another way: the old code has years of testing and is
> significantly simpler. The new code is new and untested and more
> complicated and has already caused known new problems, never mind any
> unknown ones.
>
> It really doesn't sound like a good trade-off to me.

Side note: it's not clear that we should need to do that
ASM_CALL_CONSTRAINT thing _at_all_ any more.

Iirc, the only reason we did it was for old versions of gcc, and we're
already in the process of switching minimum gcc versions up to past
where the whole thing is relevant at all. There's another tip bot
commit that makes the minimum gcc version be 8.1 due to the (much
MUCH) cleaner percpu section series.

And afaik, that makes all of this completely pointless.

So tell me again - why are we making the kernel code worse?

                Linus

