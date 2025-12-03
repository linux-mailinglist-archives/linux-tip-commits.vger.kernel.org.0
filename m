Return-Path: <linux-tip-commits+bounces-7583-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 752A7CA07D0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 18:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C36A300B6A5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ED932F77B;
	Wed,  3 Dec 2025 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mnd8EBNy"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A333191AF
	for <linux-tip-commits@vger.kernel.org>; Wed,  3 Dec 2025 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782539; cv=none; b=kiEKsS/9y/tYM3sYsR07+iIb8+OXvSw63adZ7hyYVYg8xqVe0lsYZZn91wfa2Vg+rmxym7+F1gCtP31yDNJ+VqXDE3zEdHT2/zGMRVdUwFJvicf575a7O31AIxdm03Wy63OBP/dzyQ7BWL3ecZdHJY9KrMEuLIHCsjpXbS3Ui+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782539; c=relaxed/simple;
	bh=HQM6py4WgMZVH8w45Awz2xfzO4yTpXtMBT6ahmT5NK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY2/tSPk7m2/5MlmBFWJ6aqcDguTDP92qAbolX/IiNYo6/XEVwhrds/MYX0QigVpi6rv/VMUFpaqhNTnQtMpbY66QuQRGsgyWKPFQk7myPvdh3UadUiz98DE1pABSTUG7XUXdDJIG6vi4zjvRkfvfZ/neRc1xq1zURe7iaZ5ezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mnd8EBNy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so4524645a12.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764782533; x=1765387333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+15Ep6e5v9jZxQbsjZtxDKu5CeLsir66LfCIPKo8Fk=;
        b=Mnd8EBNyiQdgVYUi+ZvI3C4r9PqFJkD+NZRq/qApYg+7CIeiVkDUhnTVRZ7A3NmGga
         W6XPa4VxSVe4L4yzPKVrZ11HYw27mAYttC6OeZT2CGpx0MetxAxNvdbCHVZ4X+nJ5RBJ
         NSseMheTX0ceVqlmTG6vRvcrEm7VWZgiSAM60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764782533; x=1765387333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+15Ep6e5v9jZxQbsjZtxDKu5CeLsir66LfCIPKo8Fk=;
        b=FiAJ+TDHNfNky757ulyW0a3nAlsxCGGe0iYZNU2optowU2145I/EDcmdiRyumCY9Ln
         ARZg+UBZ8LTg90KdhaZE0ZF7gnW/5Y3FtmobOdT1uVoEvWBLpUegq8jSJJxKD5iL0ix1
         U55NLP1BetBggvNhQl4+QyUmIfE2nzgOnPbldfIDuS2kuVadrHj5/xLZn8lAk4Hj38mX
         XpTmcLSDUr2+SXoqaUXbgKxVBKgQKd4y4mafJIM9m+IuyqffqpOBRuo5SnXz10XoEV7W
         ocdp2MzinVRArriz3t8MsFbVFJRIN9LlpKwZBn69EygsIGK3pqCb+TGFlqvjtPveOj2q
         rj7g==
X-Forwarded-Encrypted: i=1; AJvYcCUHIa+whrPoFPaVdCD20XhVTS5pcI4nG+QBOhAV1D9LS4Gt6x1llmU6oHqm3ookd2HHDeoYDCkXkZVNeSootnf5JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrfHKXD2PO7UXtX0ACdyPC1HfjubGUUSTCki5gHJBHY+ZQe48s
	OUQflIgQ8XLv6fpE7aduKzmo7d1VFE5g04l4iJ6DaqC8z7Vq39wfDKwjgNAHQJcBEVD+Sini6zI
	WFYVVCXw=
X-Gm-Gg: ASbGncs4Hac0bC7N87yyXLi7JVjVWUX9bAcr1WwAHy9xNBy8cf2bRDThLzMlrEXsncu
	vAE5Q3PHzN46OPsXmljXLmmVy4zPR69bFkuOWCQS1qZsfttrMi0G8Q6/cQ3L3mb9/QUclssnt/h
	dAFlOGWhyLefERrAs5BDXchyH0WkOiiVN5YM+7IYSIPdjeABZpNFVODiq80dyi9BeVu9RYxk6GV
	55KUmVphQEAZNnWTjkkIKdLUXi+2s1xM+bms3y6ENPcDWMQrje/kcfVrjGddYlICOCAQme0AwM5
	71SL9O7aieb1r5YVNAo+JdU2Pfe5WsiMTjC3iNYorr6nF7IRacAicqkeofrMyvYp009bRCLn969
	uUZpc+gMg/8RmVhcTfYGyG9KxjvakPpV6b8FOg31ueaAa9Rk//rD8+8iMFZn8j1ZJNgQU1iNL9P
	YcaExB99d/yPmlVZdFmgby3wByK2Wgn5g/CQ2YG1UwZ3ZMMQE5FeObyxoQ9Rd+
X-Google-Smtp-Source: AGHT+IF5Q3xZmQGDuwwmduLMVUT/Nbut6N5tT1ZR9++YfRyVkxcuRrx9E7vqts5HEfVPBMfyBlH/Zg==
X-Received: by 2002:a05:6402:210b:b0:640:cea9:6752 with SMTP id 4fb4d7f45d1cf-6479c4a5b0fmr2638133a12.25.1764782532562;
        Wed, 03 Dec 2025 09:22:12 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm18710054a12.29.2025.12.03.09.22.11
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 09:22:12 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b739ef3f739so538645266b.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 09:22:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW895tgIbzJcFrAQmC25xdXH3TSe632odJM8Zkz8jF5q8AcwY25HUmw1KS2+TrV6nAIuTHzc7law/8S77vWlRwkzA==@vger.kernel.org
X-Received: by 2002:a17:907:7f14:b0:b72:af1f:af7d with SMTP id
 a640c23a62f3a-b79dc51b06cmr309519166b.29.1764782531600; Wed, 03 Dec 2025
 09:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2> <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
 <aTBr3ImmrJQe4G49@gmail.com>
In-Reply-To: <aTBr3ImmrJQe4G49@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Dec 2025 09:21:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
X-Gm-Features: AWmQ_bkRYZH2ihB5Qz0mp_RfR5nRqODyawxbT8M-YEsSRiC5vpxFs-EcIVEbBdU
Message-ID: <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 08:57, Ingo Molnar <mingo@kernel.org> wrote:
>
> Find below a diff of the arch/x86/kernel/process.s output
> of your tree versus current tip:objtool/urgent.

Yeah, just a single example would have been sufficient, ie a simple

   Turn

        911:
               .pushsection .discard.annotate_insn,"M", @progbits, 8
               .long 911b - .
               .long 1
               .popsection
               jmp __x86_return_thunk

  Into

        911: .pushsection ".discard.annotate_insn", "M", @progbits, 8;
.long 911b - .; .long 1; .popsection
        jmp __x86_return_thunk

and btw, the quotes around the section name are not necessary afaik.

Also, I have to say that being mergeable is a bit annoying here:
without that, we could drop the "@progbits, 8" parts too which is just
strange noise.  Is the mergeability really a win? Because I'd assume
that it's never *actually* merged, since the expression "911b-." ends
up being a unique value?

What am I missing? It *feels* like this should just all be

        911: .pushsection .discard.annotate_insn ; .long 911b - .;
.long 1; .popsection
        jmp __x86_return_thunk

instead. But it's entirely possible I'm not seeing the reason here...

                 Linus

