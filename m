Return-Path: <linux-tip-commits+bounces-4202-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE275A6055E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 00:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBD6189C8D7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 23:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C51DF975;
	Thu, 13 Mar 2025 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdQL0Ebp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C041EFF95
	for <linux-tip-commits@vger.kernel.org>; Thu, 13 Mar 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908828; cv=none; b=h0LmJXWxTzIYB+d3ziw2Dm6NIxDeyKRz8PkOObEG8CYFtJd2Ly4efmGOUyblFYyIIbWX3CutmXWyBn2w87Oxmi/ttckHgYPZ04VWUe44ae63amHhxhKjZTygfl7IP1L+/SzsDwKfZMGPhEnW9E1Ky7VKgHdeOPGDlRdSQbAKSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908828; c=relaxed/simple;
	bh=d2BbL6crT3zxbAoUuy4Rpuun0vagGQKtPIulLfRfm+A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBxZBr0dvnWSYowofK2NNYAQNXHJ9n3P+MZkSWVU/QPE0oT5p2HTpeoj2nEFsyroc2xhWYX0/9Wf8SCmYtku37AANeKqr+oo7Bdx/9VoFbXtTC/eRLvcrYiJB6IgaOWwrISmbx3TyuUBn3BPvhGGh/4JMo/3iK35BLT6tUuQuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdQL0Ebp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/3v9hCM3XgZQG/uWDAc5eUlEb86hfweiLW/E08xeso=;
	b=DdQL0Ebp9LKNAT3WkLeiNHq3WSvXTuFbxMo/HdIbwC2CwZ/Jf5Ln4DzsKDlQw7Zy4XAyVx
	UO7Sx+3rsx739AwDYEuv70oyTarBnFYVukubLM8lEgtpUm8ABpF6wve+X6BD1lQHV4VsYw
	TMps3LdNTIaofF8JKYPK9MQ2gsN3ApY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-jWX3PRR7MlGsYJDZuAZpgw-1; Thu, 13 Mar 2025 19:33:38 -0400
X-MC-Unique: jWX3PRR7MlGsYJDZuAZpgw-1
X-Mimecast-MFC-AGG-ID: jWX3PRR7MlGsYJDZuAZpgw_1741908817
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so2430494a91.2
        for <linux-tip-commits@vger.kernel.org>; Thu, 13 Mar 2025 16:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741908817; x=1742513617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/3v9hCM3XgZQG/uWDAc5eUlEb86hfweiLW/E08xeso=;
        b=oXNMk7jgBcyr/emxn1Q/RSAJjLjGGi/eFNyebh1sYWivf61AIikIx3sQIOgXky4Wze
         0a/UMUsWWAF56qArg5ldB0+/BQE5yNVlNVSrnS6twe69XAkTYTtS6UlQTxY6tVv9WiRl
         pva2oYadTU5Puk+gSbqPBD2I1rkrz4K8MzRMmIrS66rIplNCh2aapmCI9AJTr2qH50Sp
         MOm8I41GnGcmnX0rIGt3mzahcP1Yk0KfMBRWsp+/oIxSYwhdkgEg7wlzlromoAHB2o0C
         C8SEXHknS3wCNbG+RTgJ9S/QEEy8wZORvgox4d7sfhqCqO2QofMEfC4CPCXLDRVQOkoa
         Jq0g==
X-Forwarded-Encrypted: i=1; AJvYcCWtGM6sDglTTboTMgW8izVU5eAJz+HRoV6VIqyYsVSeuU/tlxA+HD55hx3Kmto0egKx6jW+DJ1RLnGSR8FKQ42mMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJLOApZqeg6633/IDGbSnP0veCkzJegO4xCsWahTetJK33elT
	zZGMdlzv7HHQEpCgD77rOo7ojzrv9BbYOMxbv11fPmhSnLmszHlTyNUAbz9Yt+3fEHxHVDeOmsr
	IDQKBK757vyyjP30UbX7yaGYSCcRhXUycImCc6dEs/ZxKXoi91OEFFJ9Dq5l4OTWzVcc7
X-Gm-Gg: ASbGncsoHmnQXRPhAHOuT9786LswN6n53OE8F4W/BrpeiDdsy9uwKuQBuXl+ac7fqiN
	UxFlH69A/XQWY7pkPqixiE5HY84go6pi9ZGvpshCTFT18ImU2qjstjBRfn9fOeWRHXkJstqD3rJ
	Pq1iFfYN9z5TXcj9Cled5qMB2s3lvARNcCWiGZD2M7jjSlPGwMd3Wb8BUkRO+DKFboDQ6645DtA
	WZycya8AUPJ5bDJd5GQrnKp23kUm36qcPGEAf8rkkq0bd9VV2go2YUKnPn195wuC4y6fgE=
X-Received: by 2002:a05:6a21:6f12:b0:1f5:6f61:a0ac with SMTP id adf61e73a8af0-1f5c1194398mr713912637.5.1741908817087;
        Thu, 13 Mar 2025 16:33:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg11jUSvdZ7myHt28bo4oT7WuIlGER6PePCSXTF7sXbwm4FqFaH8DdomvUNIg5u14ALbu+uw==
X-Received: by 2002:a05:6a21:6f12:b0:1f5:6f61:a0ac with SMTP id adf61e73a8af0-1f5c1194398mr713902637.5.1741908816799;
        Thu, 13 Mar 2025 16:33:36 -0700 (PDT)
Received: from jpoimboe ([2600:1700:6e32:6c00::46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1876855a12.6.2025.03.13.16.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 16:33:36 -0700 (PDT)
From: Josh Poimboeuf <jpoimboe@redhat.com>
X-Google-Original-From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Thu, 13 Mar 2025 16:33:33 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250313233333.bdkv2xmmj5j6uwjt@jpoimboe>
References: <174108458405.14745.4864877018394987266.tip-bot2@tip-bot2>
 <90B1074B-E7D4-4CE0-8A82-ADEB7BAED7AD@zytor.com>
 <Z8t7ubUE5P7woAr5@gmail.com>
 <20250307232157.comm4lycebr7zmre@jpoimboe>
 <A669251B-7414-4EE7-B0AD-735E845C0B5B@zytor.com>
 <20250308013814.sa745d25m3ddlu2b@jpoimboe>
 <1602F93C-94B6-40DA-A2F6-B8D4C0E24C1F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1602F93C-94B6-40DA-A2F6-B8D4C0E24C1F@zytor.com>

On Mon, Mar 10, 2025 at 07:49:56AM -0700, H. Peter Anvin wrote:
> >> Alternatively, you can co-opt the gcc BR I already filed on this and
> >> argue there that there are new reasons to support the alternate
> >> construct.
> 
> I should probably clarify that this wasn't flippant, but a serious
> request.
> 
> If this works by accident on existing gcc, and works on clang, that is
> a very good reason for making it the supported way of doing this going
> forward for both compilers. Per-compiler hacks are nasty, and although
> we are pretty good about coping with them in the kernel, some user
> space app developer is guaranteed to get it wrong. 
> 
> Frame pointers are actually more relevant in user space because user
> space tends to be compiled with a wider range of debug and
> architecture options, and of course there is simply way more user
> space code out there.

I opened a gcc bug:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=119279

-- 
Josh


