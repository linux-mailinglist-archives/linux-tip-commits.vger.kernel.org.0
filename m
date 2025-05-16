Return-Path: <linux-tip-commits+bounces-5578-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37217AB9E7B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70161BC2449
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 14:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264F76410;
	Fri, 16 May 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="NeZPS+LI"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB3135A53
	for <linux-tip-commits@vger.kernel.org>; Fri, 16 May 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405093; cv=none; b=XL7cbqsc0GenB+miYWUvI/zMIKryQo4Yi3H7kOrEBHxH0j3xtkHWXtFTDCIgfHyBxcFOA4aKzrHahU1BF1FMvAgO3hM8MYoUV/13doN8eGV7kP0jf2T2Kw2HF6QromVBCtso4mSuSNdpZMb4t+Sofce7Okj0OYy9pdZctKrxte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405093; c=relaxed/simple;
	bh=eMAldY621LGBuYWnS0DttmFZTqueAPJOlZY/rBYz5WY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OhvAyLdaz8r4Kbv+7AHUVTlF0wGv4WbHBGqFHlKNklDz/HfV40rqaKzbBbrczybCheTpH6E/kTlanwiaArDCILGtq39GmUvr2q4E6HHYbePrOFkXPch5Ddlv4osKf4tKy/6zUIMBMcvdD76fFxN/BmD7DKiMTtZD0AEWliNTJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=NeZPS+LI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c597760323so232998885a.3
        for <linux-tip-commits@vger.kernel.org>; Fri, 16 May 2025 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1747405089; x=1748009889; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=owY4nRaaHwvI0FEJzLInMFg5XKLo1UFESw5ag0F5X+w=;
        b=NeZPS+LIdYd8rZsx68P/1Fr/6QxTqVyMCcRY5T7d3L4VUWLKuA10Dha32ET9/bYE2V
         JFyM0eG8ApelM+O1795yEvvIjMDLG+pobTO9QU7eZhXvSMB5IfmRs84EhNpmX+XYbYLv
         KoGphNopelw223F5CluNFoAhI3SS6yrKIQaSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747405089; x=1748009889;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owY4nRaaHwvI0FEJzLInMFg5XKLo1UFESw5ag0F5X+w=;
        b=Kec9MU/KxogVZJyxjyY3RH4jmG601Dt6dk/8scjWLvKepn5WF6SllMudN5w4aE7hvu
         LyKxo3wIAqWWWwMbMeu30RcpTA0z3q8PqILv6fRVh9lCxlLaYeB5B2l/E39l80hy6beW
         m74hMxVpW/lqgxbgT+0VjqxtZFxiKoYIwCYzU7e3QurvRh9SfExjNuIeLVLsDvVVOVBx
         DDB9Ij3JDB7+pPfGLgT6sPMbnwP+h/qv+qTo+XOQxXBNAxqAzYv/F2VuothgM0+W+6NA
         YdH6LZO9HAAxucQJuG3jvDdiS0Dg8OoTUShZrK3HqaTSAvKLzPorfFzBW8dSxHyG33iG
         W+SA==
X-Gm-Message-State: AOJu0Yw3tR5aHnTDjP29UbB5oPul1bekRNzSNNp58XGYghovecpP4yTG
	d4/qyHHydk+jTt7FK5did9bVdafGtbsB3H7LVUMn2R1GsShQpC0/wGSuOHerTg0FRzQu6gH8G3v
	BlR5fIA==
X-Gm-Gg: ASbGncv6OWsm3L3VnX41vXM1JG1qt86n1WYrbXOC5K41/09uQRlqrzRW1F8cZiIWHb8
	MoT9ZQN+/z/LImeo4niAg96A1qfpPRfIMHfa1XgrXmIiI+fDheLylb0IJG+37JVzL74XyFh52Vo
	/UQvwCGbDVdEtkBeECqLunQU/yYw/raTO3F7cBlAVSdTPyUWJqgZv/AZ2XdSGExCcdXEnRq4NBu
	AB0GKEO6jdxZOiMMmny9H4OTSJ8VcZL5YT3YlbbwFwZZUiplBP68Cum25zUwXX9E7Y1fA7uezpJ
	Kd4nVOuEXqnlV4g1wYERKU633JzkECgMM3i67Im3DmVP7OziDownqMi0TbrRd0jUTlTi6sk=
X-Google-Smtp-Source: AGHT+IHX54JGF3VTnio+m8DU2sCiIbyBg5xhIiMGOX8DYyY/nAQMnnooQoTr9NQ1eTWo+ItnU0AtUg==
X-Received: by 2002:a05:620a:444d:b0:7c5:5f19:c64f with SMTP id af79cd13be357-7cd46708138mr549132785a.4.1747405089444;
        Fri, 16 May 2025 07:18:09 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd467db690sm123338585a.48.2025.05.16.07.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:18:08 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Fri, 16 May 2025 10:18:07 -0400 (EDT)
To: linux-kernel@vger.kernel.org
cc: linux-tip-commits@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>, 
    Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    linux-perf-users@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: perf/urgent] perf/x86/amd/core: Fix Family 17h+ instruction
 cache events
In-Reply-To: <174740303900.406.5499797802401271693.tip-bot2@tip-bot2>
Message-ID: <c409c331-da7d-7424-e0db-a4c61ea423ca@maine.edu>
References: =?utf-8?q?=3C2f475a1ba4b240111e69644fc2d5bf93b2e39c99=2E174661?= =?utf-8?q?8724=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?= <174740303900.406.5499797802401271693.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 May 2025, tip-bot2 for Sandipan Das wrote:

> The following commit has been merged into the perf/urgent branch of tip:
> 

> perf/x86/amd/core: Fix Family 17h+ instruction cache events
> 
> PMCx080 and PMCx081 report incorrect IC accesses and misses respectively
> for all Family 17h and later processors. PMCx060 unit mask 0x10 replaces
> PMCx081 for counting IC misses but there is no suitable replacement for
> counting IC accesses.

can you link to the errata document that describes this problem as well as 
maybe give a rundown of how and why this breaks?

Vince Weaver
vincent.weaver@maine.edu

