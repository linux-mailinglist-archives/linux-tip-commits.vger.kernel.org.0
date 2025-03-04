Return-Path: <linux-tip-commits+bounces-3955-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D0CA4EC74
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B391885EE4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6BC20AF69;
	Tue,  4 Mar 2025 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YuCEvM5k"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868C20E6E2
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114130; cv=none; b=Gh4nS24OFbiVDkv9pTkea7X9KwJFc3GDhGCML4wqXbzQTEaRYTHL82jcybqhVpPHOIHBlYITkJm0DHmE/DfQj8E1TTMpM5vg5SoAjg72a1K+96FZk/5zvmDC/efj+wEbfLmOII40JhAUf0N0xBNdV87cKuZiCyKONh2OFvVcbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114130; c=relaxed/simple;
	bh=KvrG3UYpihGsPQkJiVzXVu3yOw8i8R2qlV9YOjObyK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXfUvI96Qb0+N8hapSiu01GE8MV+SA5BtjTTGQJuIhEELY0FYrb0FQ4SR5xaS73IophQRDD1JIQFVdGl089hvRRvA5yz5W4h6mjhdG/bvQ81W9+19er+yekD3gzzbj1UgoRCC+Gi1TdzdxfmYFIEfrEkLOE0gw9aEZNsl5/WitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YuCEvM5k; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5050d19e9so7465949a12.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 10:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741114126; x=1741718926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OuB99XEjibRdIGozjeXGZHXV949oela18xWJ3pUZ9Ts=;
        b=YuCEvM5kaPN7zW7zAJ0CdF++gdtEpzE6xYotoiEeE20TdmJJzF5xRfeFLZ+xT8+t9G
         cADK8emyN/TYqfcyhpl9IyIcF3U8DVPzxxvTRRy/ceioic+2hg4Dx6mTsaWrhGSnbEWa
         utDQXQ1K5EGX5HQarMk3axNgTwhODG6bwChz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741114126; x=1741718926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuB99XEjibRdIGozjeXGZHXV949oela18xWJ3pUZ9Ts=;
        b=jBCqemlX+gNBoGYmQzqEJbrMMW6hvyaR4Zop4QsN3z8kfdvIxHc0zLSF0utc3tajlO
         jAkQaiz4qLqBJGZAO7JOpHVtgU4YB6WWyWWCxRJhjilxNaJvb3WI8eNnzKMrMcUCXY1B
         +ZBaH0RupUA9UxO4mi0fg8A7ZmaxlcwhiTkHqrXRZLLfuhPQs3ZSTWAtxs5dh817atuT
         vJB4140tSr8txHa+PQF8aF6NTYiXMvZXRr5K5QeJ+ux2ACikEX5g97v6Sl+t8Z226wzF
         O/Gi358TpPj+OX4kj/d2a2FAbWeh3wdH0eBnCjLJXoUGbL9dCMWjRAab0w9Jr7Ak+Iog
         1QFg==
X-Forwarded-Encrypted: i=1; AJvYcCUyhoReo4EGMksDFe34K5d0SGxz36fMSv/8hvKTaWO2c1iZrdQ1cHEu8+q6K3fF3BPrT2WM1vLujVJV9ahIvdJPUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yykt8X3qjD3rTSjWfgabtIms3v/4JICtmVAHugOD2kzHzuKCsv1
	5pern5NE6HcIJJBt57IxpaqmQ6jkUdagYcQpCLdM65y6RPH4zFceK0MHWgw3aOeiO4mn2UhZ/Au
	hWtOWxg==
X-Gm-Gg: ASbGnctOYYMEwqEEgE45y1RuuIuEyi3gq6ihOqdbMU9hVclUoGN2NIhDQ5Nw/vKmLPx
	p9M7nkiVxVe89n/yJNNOgtZkuQ6jO2eNqpeK0mAhTK+aJPyEoSJMGhVkma7oqLFs+zyzolTTFvC
	VblhJFN+nd0Iutkk1s6XVO9vUB1G9ZTGuTf7MT5aISuU9BkWwdd9hN720Pd/CODi0DibVcOLEUJ
	3Fhnk9Ko7HImBr0xenxVv9b1sO8vrEGwr6YVeROvfk+/fZkB5gpKVWZPZOWXNqzb9AI/8K7qwbX
	5CXO/DACo0elyJ4v1HE9fZnB7SRL7fy91Mjm8lzVrbE4fb+h2C8LonjLwyEJlK0lLrS6vbTnql/
	6bVmXtotYepU/TeEFUc8=
X-Google-Smtp-Source: AGHT+IFLV+cz/NpokhBGgPLsa+JLpFg1LlfHXG5m4l/IqYP4ZYXSRfvlnHCzjpw0aWUY9+tOBRRw+A==
X-Received: by 2002:a17:906:7952:b0:abf:7ec9:fde9 with SMTP id a640c23a62f3a-ac20d925347mr42170866b.30.1741114126520;
        Tue, 04 Mar 2025 10:48:46 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dd9f1sm1005756566b.62.2025.03.04.10.48.45
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:48:45 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5050d19e9so7465911a12.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 10:48:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCrW1zcxpdCRLX0+vua+NJ7QeHm5rQH5imd7NErtxrNzzhnEMcPfNxrFjPikz/nSY1p+zy81CIc8wV2KO4+z1mnw==@vger.kernel.org
X-Received: by 2002:a17:906:dc8b:b0:abf:742e:1fca with SMTP id
 a640c23a62f3a-ac20d8bcb34mr40348266b.18.1741114125409; Tue, 04 Mar 2025
 10:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com> <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
In-Reply-To: <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:48:29 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
X-Gm-Features: AQ5f1JoR0UB9UqGJBBKA99pH7jooWGFdTpOHx-xCCHAEUPCx70AEUbGOKmD0Lgw
Message-ID: <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 08:21, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> I'm utterly confused, what are these new problems you're referring to?

Random ugly code, untested, special versions for different config options.

> And how specifically is this more fragile?

Random ugly code, untested, special versions for different config options.

__builtin_frame_address() is much more complex than just the old "use
a register variable".

> AFAICT, there was one known bug before the patches.  Now there are zero
> known bugs.

Big surprise - since it hasn't been tested on very many compiler versions.

> I'm excited to hear we can get rid of a lot of old GCC cruft, but this
> has nothing to do with the compiler version.
>
> It's needed for CONFIG_UNWINDER_FRAME_POINTER, for all compiler
> versions.  Otherwise the callee may skip the frame pointer setup before
> doing the call.

So you claim. But the original ASM_CALL_CONSTRAINT code was for a gcc
bug that was reportedly fixed in gcc-7.1

So is it *actually* required?

Because in my testing, gcc doesn't move inline asms to before the
frame pointer setup any more.

But I actually didn't base my arguments on my very limited testing,
but on our own documented history of this thing.

In your own words from 8 years go in commit f5caf621ee35 ("x86/asm:
Fix inline asm call constraints for Clang"), just having the register
variable makes the problem go away:

    With GCC 7.2, however, GCC's behavior has changed.  It now changes its
    behavior based on the conversion of the register variable to a global.
    That somehow convinces it to *always* set up the frame pointer before
    inserting *any* inline asm.  (Therefore, listing the variable as an
    output constraint is a no-op and is no longer necessary.)

and the whole ASM_CALL_CONSTRAINT thing is just unnecessary.

So I repeat: why are we making the code worse?

               Linus

