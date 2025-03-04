Return-Path: <linux-tip-commits+bounces-3996-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58BA4EE49
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 21:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E84D7A3DF5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599C1FAC46;
	Tue,  4 Mar 2025 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y0Nl5Yx2"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5907DA93
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119949; cv=none; b=j14Dnc+ydG8qPof5ILmhf/hlj2OviYeiZqnpi9famT/yyPs+uKpqZhNjLBnBkDA2X8uxwkcNvYDSyTMWBTUHczRiKjyKpsXA5Pk2zvKT5K4ckhsME7tQNOCyq4+j4iSM1S9Jj9dDGp6Xtcjf/c1uXLUxjE6qEDo0UTCU6ewjmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119949; c=relaxed/simple;
	bh=X5RiZHBsbLcPKV323Q8tWpZ073WfByOYU3vrxNxusK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myMXGb2uBG3mVyLuTaDb0bMZRc+LT5J3DH0SHA+DDkO0UDLyKz3GMwCG7eJBv+cYGipGydZRWF3svVQokknp3mwzfr9UujMnrKzzks1oTYTmV6JvEJFIL2gKJLjPrkPZg2hAP+BdthqdaWUcszSDYMAFUTpDZ8SJmexc4ghAMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y0Nl5Yx2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1126912266b.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 12:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741119945; x=1741724745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ng6/HlQleweYy73ZBFOZ7zU4VxzpXmmE/CHm0RKEds=;
        b=Y0Nl5Yx2j+BlmEuS/PAv3Oo7E9hLu4VzlJ9lGhTWlb9DyqMQU26irxlbSK1p5lCknX
         tqim2ldVL4++EnF2Zvq6/dF+l0MYbww9D8C3YRAyexDHVdHUqMvHL1aAn/2yhq8bvykz
         Vz459Bwwa3Bf9oGkEmDZ0FzU941KwhOPKSp6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741119945; x=1741724745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ng6/HlQleweYy73ZBFOZ7zU4VxzpXmmE/CHm0RKEds=;
        b=rJVnUFAmpFBoLzj4Zf0lnPoR/vweiXRp7+Eybm3ZVecW9fb0yMaPiV/5HbiflNozhn
         SDFy74fGyLfY9skBnzBgMjRBSi3uTtt92Ec5SMDWy7bFMztOpL0NxhUn4ZX07BXu6ml2
         L83Lp5wy1q5bd4yqYKBxwMnpQrcenHejaRU3723aMi9LfRuLY63MKr8CmgtZerb1aS3R
         qko/DkZpUoOxWNrDnDpfneuNj4jhJfpQP+SqKQ+u2bdzooWzzYXVvm7hDNjI5eFSUfn6
         5Ts1CC5Y+YJj/P65dfO+9NYyZ6R2QtsfPWZZYqbuADPpzq0W1oMlmCO8h44hDLTmudlf
         CQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCX/1E59BDUFeNTMsdBWQ1pQYg1HgeHsS6RDJz1xjtRONo3qRnKvImM2P8Ri6/qpJuawnaop8O4Og1WsHuRC0GA1yQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mmblRVNtB61gdJyFGvt6/lAFmVfSr0ZKgqkIJvBAWiTiNwsA
	hW/22WiYgxxnTFQM/wgLpmXbcmxZBe+COhoeeaTkziFSXOBp5jrhlfnbaXb1bmcEPuEPlWmNmm+
	aKqhjHw==
X-Gm-Gg: ASbGncvL+zmb5oMrsvCY8cMRAKs9t1FBvMUF6oE32l/BY1SXEm6YbCHLbRzNnwRMu38
	Aq5pVxxhSpNt2bAndC6ZlaUSH3jfPSCkgMJPJTESgIdDTVNI/q6Km/ZeHrACW61RpXZi+MFNpeU
	SoXuJ7+5hvpV719VMj8lUD8DH9YqmhOjodNXkTo47pgp5ts8iwYMkMeXlf1apyv+EFe3Fzp8oCM
	STL5JMRrKgSBHcyGWa/NuSNjLud443O7MmHoGShLSHI7HFaTWm1jxBAegXA6NLf/HchP6gKS+Iu
	fMVR2a2FKVdklELtTpmJLv75piAGdVs/jft1+gff8yi2etMV3YmwgegLGNZ6E9NCugc+tKsnMTx
	WyVrRNq8HBvg0s5SPH7o=
X-Google-Smtp-Source: AGHT+IG5hiyli2usV0Yd/no+Czyjk8P1oYBWkKft7OsTdT8wFh+InFBvze9ngpJkFLaMNKzJCd30NA==
X-Received: by 2002:a17:907:2dac:b0:abf:70fb:7f05 with SMTP id a640c23a62f3a-ac20dafc173mr62850066b.50.1741119945312;
        Tue, 04 Mar 2025 12:25:45 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf67fa3c05sm518685166b.72.2025.03.04.12.25.44
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 12:25:44 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1126909566b.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 04 Mar 2025 12:25:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTT3UPwuTkunUKoUwUEkol/pYRR6xnre+d7L5POyNIqJ83+5kp8WpXE4OXurSIMeKkrU9slc5xAvJCWZ9rKoRK3w==@vger.kernel.org
X-Received: by 2002:a17:907:9496:b0:ab6:362b:a83a with SMTP id
 a640c23a62f3a-ac20d84509fmr57802866b.8.1741119944023; Tue, 04 Mar 2025
 12:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com> <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe> <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
 <CAHk-=whqPZjtH6VwLT3vL5-b3ONL2F83yEzxMMco+uFXe8CdKg@mail.gmail.com>
 <20250304195625.qcxvtv63fqqk6fx4@jpoimboe> <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
In-Reply-To: <CAHk-=wizdAA_d1yHZQGHoJs2fqywPiT=NJT2wNA0xybV+GVefw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 10:25:26 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgtnKe+pH2Sx7C0u_UDzan6paTMesRDhAyDEAcCptyuuw@mail.gmail.com>
X-Gm-Features: AQ5f1JrMDxVLcTEMY5jJ6-t8Assg5ksjiB7T5IGpvzD8oxsD3xGemkRL0m8NNVE
Message-ID: <CAHk-=wgtnKe+pH2Sx7C0u_UDzan6paTMesRDhAyDEAcCptyuuw@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 10:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 4 Mar 2025 at 09:56, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > While that may be theoretically true, the reality is that it produces
> > better code for Clang.
>
> Does clang even need it? Last we did any changes for clang, it wasn't
> because clang needed the marker at all, it was because clang was
> unhappy with the stack pointer register define being local.

Put another way: if we make this conditional, it would make a whole
lot more sense to make it conditional on the *compiler*, not on some
random kernel config option.

At least making some "use this to mark inline asms" be
compiler-specific makes sense. We already do exactly that for other
compiler issues (we used to have the "asm goto output" gcc bugs that
way, and we still do asm_inline that way)

And as far as I know, we've only ever needed this for gcc, and gcc has
never had any problem with just using %rsp as the input - whether as a
local variable or as a global one.

But regardless, changing from one very tested model to another, when a
gcc person already has said that the new model isn't reliable, and
doing it for gcc because of a *clang* issue, really seems all kinds of
insane.

                 Linus

