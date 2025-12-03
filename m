Return-Path: <linux-tip-commits+bounces-7608-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C1738CA168A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A1843002E89
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE0337BBF;
	Wed,  3 Dec 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gv7yvf9g"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5D32FA3E
	for <linux-tip-commits@vger.kernel.org>; Wed,  3 Dec 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789869; cv=none; b=iUfgBvWgdyk8k7LYeuN/LgkhRZF8cyVrG1aHu8n4ACQtfzBm0+gqoZGVCTAhzt9KiIZ5pBBbM2U9JiQKhl3p/+SHhxTOIWzt3GWtVCRQfMq4B5dixGiBN0vNS2reZDGYL0MrbpEYIhGh6RBfYjLBbj+thzNzh1InbCb4cgoLce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789869; c=relaxed/simple;
	bh=F4PXjP+RrccWd8fMVxzojCVtxDPiX6merDkf5iv93/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeyKWn7o+KIlMHhSl/7qaXdxVSIPWCjbgV2uuACeNLbHiGX2Y7TYIRFX3RCWvgtMCjB/+fvMyTNcEs9kLIkbH1Ji39Be3zB/+6+8Bj6QNKzerWEdBk8+5N3asjj4D0ChCTJ56zIhBMsKS+O3XE2108Ks0gC+3vKhZgAD5H61b0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gv7yvf9g; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso97091a12.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 11:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764789865; x=1765394665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6t3O9wsrWVresMuWM0Ttp6NRhGV090rBK1GQQ6ToRkc=;
        b=Gv7yvf9g818eDN5wikyMHYMVJmU/C1mdwfoG/XlaKbT0si9LR+DAmt0p45UMZnY3Rt
         RnmOnGwf+A7F1RPKpcEv9zZHD69uqLsJlipkLUBLAYz20wk7jbdBateAtfV8m2hzGScp
         VSXVINqIk2ZJZynZNOWxtRl8nIu+a2yHHrZ+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764789865; x=1765394665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t3O9wsrWVresMuWM0Ttp6NRhGV090rBK1GQQ6ToRkc=;
        b=ViotT/nXcX6/DMwLrVfYtaUK2ZRYGxBzw2Mt0vEGgTL+/noHxImVrSsxRAdzPXYDYF
         eiedhBTSVa5fQW8gLcNxTP9Lno/W8UAcUqqlTswfHD1si/jRZ0MEWljHcUFBk75rM+/+
         lrk6pinNl9LfXqEjBmoYX3jeNNpMEzMkQ9Lqf6TbSxSB3Q5kC6G2P4d8gqdUqiyU5dOC
         hbTOHhHUQOuDIPte9N7XD2AsLIAQ1KfB0oZepZ9YRycRuShik8qvC4WNvr69SwSlIfFC
         IRvVUkbFT06/YzEY5NRpiqt0FKakwh7FTlhnjJdEfel9fLNigrlnAFDsD/GHmFKKAfvF
         mnig==
X-Forwarded-Encrypted: i=1; AJvYcCU2whVADZGMXf0iXubEABpVDs0RAJU2Yu6eD8IiQEh/9KUmW6uFyBpqjKJA/9bomwoY4g3IYHzNDw+tgditJ0AxEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xUKckcJPW6Q34se9AwcutMdTyVVnbtKtO7uMYRsIeYGJfXz1
	eZqEH1JLfTUAWcbCFYgXbyaJ/MwgdKA8mnGq3vr1tZ3h2TXZgpUYNedkykdVrx51ruzbBhkU/a7
	DOcS3l28=
X-Gm-Gg: ASbGncsufSjJDo4q/GZQS0rGKF8P+0Cgv0FYkfIV913BeV+5y7t6YT90lgkoaMQAxsr
	Pv0znGvRTQDzbXubJxfmC+WZcFWow7Jfa8KUirLJZSTAa+o4KYK1Ytk0H0BnpV2xwZXGge8E6Zd
	tPS0WdEtHDiejnf9LxeomgsgxzcURKD8MWrj+JARA0kR4tTtxQRLoDKNuUin/PP+0762YBag+8M
	KglTJmnmQJXceHRCi8KkzTioHerGf2ay7Q4i3BkJ/3frRd4KXEg4NiGHfYm+YfsGL/lZ8mZuN1E
	f7JaCppUP2tK1W//0osXU2se36bO+W/bNndhFHhzf4ZzwcVNi2WF+usmI8Gp2ZW/d7Ar2bGGmRc
	xV6xOF1rqtsPxiafO5pL9hKntW9Wpan9bbPhVyDC57fiNi5HsYmyt1Vk0ZRgcFGa0HdxWvWXY9s
	tHFCd/bSJrVgoAmTziejR2jKBKdxztZS+/t7gx0ChbblgzYLG4Nx+VlIn/mU85
X-Google-Smtp-Source: AGHT+IFSOcM8JQzWYWpTOreSKGGlqhjGZMn8/X/i7OjDCs2cnI7YyH4SW+U/kLbZVRkNlIgYrcs91w==
X-Received: by 2002:a05:6402:2110:b0:640:952d:f61b with SMTP id 4fb4d7f45d1cf-6479c469c3bmr3067078a12.22.1764789865302;
        Wed, 03 Dec 2025 11:24:25 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035d4csm18622039a12.21.2025.12.03.11.24.23
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 11:24:23 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so121661a12.0
        for <linux-tip-commits@vger.kernel.org>; Wed, 03 Dec 2025 11:24:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWODAtq5KgV4sIcVzFPWSLFondo36lxGvk9ixOvI2QkuC8IsI0sh6jNELF35jZiYfj9XkVCHFNXXEL+7jCYiSznfw==@vger.kernel.org
X-Received: by 2002:a05:6402:2110:b0:640:952d:f61b with SMTP id
 4fb4d7f45d1cf-6479c469c3bmr3066961a12.22.1764789862878; Wed, 03 Dec 2025
 11:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2> <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
 <aTBr3ImmrJQe4G49@gmail.com> <CAHk-=wjc4BeSu7dHB=5AuQNWQ=sOGAuH4j0=uRwsGyiSo+m+bw@mail.gmail.com>
 <72juhabxma7rw5eq2gglct4lmeoqfvrlv5jf36sdcfimz5rxxd@gnfuxdgv6stj>
 <CAHk-=wibTBOrb+T67uBCuXXQxDNtsS_KdMQCvgorUC1CPdHwzA@mail.gmail.com> <qhj7tqo35lo3fhl7ne5yl4pw6kp45c6owc75f4cj2gyxot2ldo@aizhulohwmmu>
In-Reply-To: <qhj7tqo35lo3fhl7ne5yl4pw6kp45c6owc75f4cj2gyxot2ldo@aizhulohwmmu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Dec 2025 11:24:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJsz2TybxsxWMEXio4FVfUoToT5Tb8VmobUpuekemA=Q@mail.gmail.com>
X-Gm-Features: AWmQ_blOXXYVgnXPwYZgwvMH3hgQUlWUFS8mL8wU5vj4Ep_hSSbLt0lQulh31tM
Message-ID: <CAHk-=wgJsz2TybxsxWMEXio4FVfUoToT5Tb8VmobUpuekemA=Q@mail.gmail.com>
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 11:17, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> > What are the actual entry sizes, though? Because maybe we could just
> > use alignment instead - which is trivially settable in the linker
> > script.
>
> That could work.  At least .altinstructions (14 bytes) and __ex_table
> (12 bytes) aren't power of two.
>
> We could certainly pad them, That does increase memory usage though.  On
> my defconfig kernel that would add about ~11k.

Ok, if they aren't all naturally aligned, let's just keep with the
horrid 'mergeable' thing for now.

It's not wonderful, but nobody sane looks at the generated asm anyway.
And regardless, it's better than it used to be.

              Linus

