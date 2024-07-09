Return-Path: <linux-tip-commits+bounces-1633-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2892B1B2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 10:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD241F21528
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB4B14F9D9;
	Tue,  9 Jul 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZGPd89Vm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GMfXEexF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A54D8D0;
	Tue,  9 Jul 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512046; cv=fail; b=LrWk0EMe7smeAo329K6OWL7jWelV1gat0oYCwKTzcjjQAVxLm+U5aF+9b7hSuwpLIPAvF0tjeYZSMaoDMD03SGivZWpGXXELRbliedxjc8Z6liKvyL2B+U8zKIgKgWVpXzIL1CCZGAf6hYiPBiCXM8wfBZCNTP9xGiewWcLsyhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512046; c=relaxed/simple;
	bh=4dxN7ySxLYc2Gr6vSnIREIQkGD+dQP142+8CSNzmXnY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lqfctx8Dz03zj5Nbw0cX60UrWOatHFWAqPeNIGjBHzH8FLl8SNlyK/1dIck+VqEJKcaD6oi1kMtOe+QCRLaYorLHHcfwh9O925hlB5MxHt/sEnEnwp+VgyHsAioIaJsNl13r8v/L+yplOmWjLFynBzSO7kKnHhjFJNoTxtm+KdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZGPd89Vm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GMfXEexF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tlhd009646;
	Tue, 9 Jul 2024 08:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:cc:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=FWdXXpad8uaoadEFegrqkmnZe6ecVSR28B4xqHhRL4w=; b=
	ZGPd89VmvecRJH1o2+U7gNI4jMUJoXvO7sbI0BNtyWWAK0MXUTAh1YdFgYrmYDKt
	gZ9tcwWGIb+Trxmtls/15MuVpYGfcegcPY1YfX1qaw1+a8JanzSxgG7XgM51jg5u
	NPo5SaL4NWfnnYGmRm1q0XwvxRytsU9UyPxYgXW8UWrD9AesG0iQaGx4qXONj8ao
	/7avmgi5Wli9MLKlj8vtouI+cXAntZtgSeaGgHISM5wxJLsrIUJaLpRocWwwpXco
	5VDuvY9KTsbj6y0ywFMKWwBEBtv8990b7htgjpI4K1SkE54A9/4H11fWGwMAC+VP
	qF+0CCHR6YVpeyTQcdqnJA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknmbdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 08:00:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4696Qh4J013579;
	Tue, 9 Jul 2024 08:00:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txgk9qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 08:00:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6GJ3ndMxTUd4jSBdch1YWSJD15MgbMSxXBz47mwsJ496IFXE//ZJLK9WcD/5eTVDyObfYLMDJFQpBhXuWb2Au1zPC5Z0i6+bXPQ3xBaHVSQUdiCRR/SRsTtS2JHNMdYl/xiFV8mcjuVTYm92QMdAyFNqWUnvQYBfPP+I0q/4sBjuDQ9jxxDHZEsm+WIuZnHj79ewPidbsBd93D7QUp8M8+XHWsOBzTgdnB1KqppGyldqj0+iNXJEDhmZpo9cM/ToVdvJfhGPTayf/ZKDGfdO2hoTluQQY+HfC0WAGVese0qV7v57bEtbw9EmEDkH75XOBKwwJRnPzJaTlAc4klGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWdXXpad8uaoadEFegrqkmnZe6ecVSR28B4xqHhRL4w=;
 b=QBKKE6sE5FSdm9fay/mZ05bb892KpRYCbl2Umj3TRQszmYhYuIjtyneQZEpETrEdajorRUVc6ZmpgJ0lbCIZMzkFQv6jJs6pGyUBKKo+Chv+txaGXTJjDJ6wU1Of114PYoK4YYCyMHjcYUlweBzcWtZXUG0/m0pHna1R/iiKVKjpUzqAof38fL4GfwZWteA7FkElvv3sIN9Z84BPxKzHA/HKD6sSDKmpqyY5Wuul2It4HP4gQBsnfr0EzW5R1GuPu8f7OKylh3LV9sLuT2eYA8jIw4So/k/YgzPMwfiP2sXNcb5E+iifxnj342JHueFErOulsCHlrWXiUC1WjfSCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWdXXpad8uaoadEFegrqkmnZe6ecVSR28B4xqHhRL4w=;
 b=GMfXEexFP3kI/YCUB5a9JwxfUgvxFqTkB+RRX5ePwBLK4eVbbOrfuyaruZRJGjvyT9bZJ3LCvWx46YjFCk0APJEX15eurP3cwvWmtPETadL6fNlYykNWvZRFHHTRyKgBhWkdDsslxSwgBERLDe5VHzuYenetfmxWg+QplhntQ3I=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by BY5PR10MB4276.namprd10.prod.outlook.com (2603:10b6:a03:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:00:25 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:00:25 +0000
Message-ID: <5a2fb3b0-e469-43b4-b914-4ca0ad16b808@oracle.com>
Date: Tue, 9 Jul 2024 10:00:21 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-tip-commits@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool/x86: objtool can confuse memory and
 stack access
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <20240620144747.2524805-1-alexandre.chartre@oracle.com>
 <172043936454.2215.16620277258416300859.tip-bot2@tip-bot2>
 <20240708164846.GFZowYbmQpBu2Y4GeL@fat_crate.local>
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20240708164846.GFZowYbmQpBu2Y4GeL@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0165.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::15) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|BY5PR10MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5a7efe-abc8-4d82-b5d0-08dc9fed30d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bms3NVZOdVJMTEdud1daTkcrWlZHY05tajVWUU5OTzJkT2NOQTg0aFMzTFBH?=
 =?utf-8?B?U003VDVhek9kMWNUNFJGei85VFFNK3VUdUZBNS84d0JaRGtEUU9GUHJNbUIv?=
 =?utf-8?B?VmN4V2lxcjFvR3FrWmVES0h4TVJGbW5DS2tTVDlVU3BFbXBkM2YwcEl0V0Uz?=
 =?utf-8?B?SDJkd0FScU0xOGRhTWk2L3VZM3FIQU5WQlN0OEQwZE4yenNrYlduK0ZMWW96?=
 =?utf-8?B?c3VhV3FtVjRDYXJzY3hXN1ovaVVZVDZONVcwNGNiVmE4MmdnSWV2NjlzbFFB?=
 =?utf-8?B?ei9jRG4zdVpHcktab2J0aU5SSWNLcENYcUFaN0NXejNaV0F2ditLZVJLTmpK?=
 =?utf-8?B?ZU9KRVd2a1JnMzk0MFBjQUh6ZE1pSktRSDhJS1EvRWtWai84eTJKQjN1OWJv?=
 =?utf-8?B?U21BTXpNYVFJQm5Lck52d1dBOFZKalM1emd5ZUNydGJ0RlptaitLU2dJUGg5?=
 =?utf-8?B?YzdUbG4ySGhJV3FlUzNBeGlNRjBDNlV1YUNnYUpSdURvdmFkWHFqT1J0dnNU?=
 =?utf-8?B?M1E0NXp1dndUdVlVV0FpNFgyN1JFTGtxM3lrR3VwQVpaT2VlcmIvK3pLWTdi?=
 =?utf-8?B?MFRRdmIzV1hFVjhVR3U2NG1mUjNIN3ZNVW5hdWlRZDV4bDNaVjEwcmllU3Bz?=
 =?utf-8?B?ODNZQnFvMGcvbXMreFdJQjFpM0cvNUZpdGVJY0htWTYxNlpIZUxMVzJLVHBN?=
 =?utf-8?B?bE1mVjl0STZIcW1wOWJ1Wk9YNmxVdGdTUEpKcllRaytjUlRUTHZ6bzhhbVlG?=
 =?utf-8?B?cnE2VnpZNnBHdDRJR3kvSW5Pa1lBNUZMWC94ck9qdHZyYStVZVlZcnNoSG96?=
 =?utf-8?B?Rzg2NUtGTWI2R3BSUHNBZkRjN1RoUlZpWFYvWHE1Wm9DTGE5aDhGVlRvR2ow?=
 =?utf-8?B?NUkzTlNFNDR5UnRTZHJZWG5nMWRhOW5Kc2RoVFJZY0Q1b3pHV2xaSUgrdUNw?=
 =?utf-8?B?VHNONndWYlFvdHAzRjM1SjFOZzdwZ1RvOTJCUHUzOFNZMmJSTGIrQ2JuRm80?=
 =?utf-8?B?OEJESzJTT2hHWVZ5cHRoNjFIK2YvbVNjQVYxK3djY3VONWt1N2l0MTgrNlFh?=
 =?utf-8?B?MVF1Z3lBMHFaUGJWcGtYekVkNDhub20xeGdVczdEdEJ6OWxINTd5cDUzOXB4?=
 =?utf-8?B?YVV6RlRJQ2hRdUF2UEo3VUVQQ3QzUVJyZnpEaFR4c05HbGsxTUtMdUhtRjJp?=
 =?utf-8?B?NlZxVUJwRWtIWUZmaEhQSWVFY21nZ05qdFRSMmJUZVg4MldiaFhrc2kyb2FQ?=
 =?utf-8?B?VkZJR3hoOVI3OXNodTVaNTk0ZVJ0ZzEvRDlaRzFjUmkzWFIzbHBHY1JDRHJT?=
 =?utf-8?B?Z2s0YWJtVjNzRENBRkluTnkvaVN0b3VnaXJhdFdJa0RyR2MzZ241d0JOVVJj?=
 =?utf-8?B?VkY2cXUycUM5bmhEMkRWQUJGeXRWYWNyeUxFZml1d3g1V0lXeW84YUwzWFNC?=
 =?utf-8?B?cHRWY0IrU0o1eTZndHRlOWtaQi9laDdRSVBLcnBJV2JhNEZ1Zms5TE04dTJs?=
 =?utf-8?B?Mnd4OFpLOUNndTFyN3NZcVZmR3A5UnllSjBLUmgvT3cxNmpLNTBabTFPL0RK?=
 =?utf-8?B?dElvWEFYcWpiOU5EYk8xci8wMFIwQkN2bThXRkZscllNOWJzVDM0QUJxYTgv?=
 =?utf-8?B?TjEzUi9zb1NpWXplUzhQaEIvQVJ1LzlJaWcwVURKTFB3YlVvR1owNTNmUmsv?=
 =?utf-8?B?dHNvbTV0OTFBWWFneEJlWmtzblpVMjZQRytNK1VsWlNaR1Uxb05teXlaOXRK?=
 =?utf-8?B?bDY3U3FiSWJmQW5zSXlsWkFUN2R1bkl0TUZGTTdCTDlpRUVXL09nMFdpQkxv?=
 =?utf-8?B?TkJZTFlGYTJYdXROSTFRQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjhXZFVPcnRrYVYvcFFKTFlreWMybDhhanRtMmV2WDFXQlRRenZLU1dQRlFL?=
 =?utf-8?B?ek4xaDRJMjZFT1NtYjBrQVVmQUVRc2d0UDQxbW5KOFVYek1UZ2xvMXN2eEps?=
 =?utf-8?B?UWdYNG9DcTNtVFlTOTRodCtKMHJlNlk4VmlBTGhybUVLNUNuSnc1UVNYeW42?=
 =?utf-8?B?V1diV2hsOXNhSC8weEp3VW1LaEJKaVNXS0ZLK3hGdTA3TWJNbjA0SlEwcFUr?=
 =?utf-8?B?Z3cxL1A0NHoya3NuQVdzcVFTVUpPa05jN2tpU3Zuak93dWRjaHV6MHU3bEVU?=
 =?utf-8?B?QmMwMEwzQnZBUjZNNzlHVVlVb283cC9QRkMxczhwV0g3MFIwU29HNmE5UmZH?=
 =?utf-8?B?cWorUXdjWHQ1NzFKVWtWb2kycEphT1Q4a0JuUEpadVNjWWxiMTBsaDRXUnEr?=
 =?utf-8?B?d1NxL3pBaVJsblIvQjU2V2lnbWp4OGI2R2ZsVzlUZXBWSE8vVGNmcVNYeVNS?=
 =?utf-8?B?QWNCNWhzR08zVFlkRlRxWmpvNTFNZzZNQzZwUnBGK1BvSFdYR2xKT3dqNWhT?=
 =?utf-8?B?WDk3UVZXZTNsVWtIRXE4dGdTWGNXWVA3UVFDSXZPcWRGWlpScDFRVUNVa21O?=
 =?utf-8?B?eVdzQkY1YURyanpyWmFSWmU0aTVSVWZTb3BKV3VjRkgxVTYvOVJlM3pvaTg0?=
 =?utf-8?B?UGhwWW5wc09EczIzQlUxNXduaE5yMml1bDFwRVgzZmFucEUySUR0UTJ4eXY1?=
 =?utf-8?B?cXVGZXVlL2llNVNwSDFEZFY1OG5GWEFDQ0lydDRBeStYL1p5cVRuUjZ5ay9U?=
 =?utf-8?B?YldyMzdBeWZDTVpwNXdQZVhIYTYxZUlQb3JONFVtb1F2a1MzV2dCK1hObi93?=
 =?utf-8?B?K2ErMlVXNm94NGN3Z1V4cW1ZMmRFRmpDbEIvVDlBWVpqazIweXFkOEhnaTBB?=
 =?utf-8?B?aXN0ejgyTXBJK3lQcUtsbUVIeW5CbHhVVFVIU1FGTHhWYUJwYTVkcUF6RzdH?=
 =?utf-8?B?Q3lTaXB1aHNmakJFNlh0S0ZQejdxTDhxZlo4NTdmbjd5LzVoTjEwVXV6L3RW?=
 =?utf-8?B?cWdlUFV2czF2QnFSamh1SEtsOE5Lb2VNVzY2ajZQVWQ2YzJyWU1jbFBlelQ0?=
 =?utf-8?B?R3VGQ1ZVSkRtOHdUYWoxdUlER1hucEdOM0ExdHVxeU8wbExkTVJDbTRPVW14?=
 =?utf-8?B?V0VhbGd2SStLdTJSTmJtL0Z3V0pBemFiWTF4U3E4Z3FVZG9wK0pRZ05rNHlK?=
 =?utf-8?B?dlRwSFFrT0tHR1N1bmV2VEZNMVBRd0tzTTYxSXltdDFwczJ1YWtvSnc2ZW1x?=
 =?utf-8?B?QjhLbVJQWHNUNnh5R3FxRFVGQ01ORTlKZ2R6VXIvOW5wbTlSa2ZjYjFhOXNz?=
 =?utf-8?B?Q3d1K2ZyME9Vc1pJR2lwaEwzMm92K21nejlydFF1RHNqVTNEelR3bUxpSERn?=
 =?utf-8?B?QUMvQll1TVZjd0g5dWt1WDBxSkgrcWlUbjcwZ1hOY01OOWthK21lSkRRUFBq?=
 =?utf-8?B?eDJOV08wcTczc21BMjRYWUtkam5rY2M2bSthVnc2aTJxeTM3dkc4UzI4bUFo?=
 =?utf-8?B?aEZ0UXpiTEh4QVhwejlLSmFHK0NYMXRjVFpqdFhLWXlOeEpxNThUdGtQb1JC?=
 =?utf-8?B?aUhGWkV5YUFsWU9uMXo3dmtCc1B2b2NkKzBNeHFwRE5IWTltekxtekJPVGhr?=
 =?utf-8?B?akROVEMxR2tGWkt4UnVWaC9lZUkzSjNLUjZaajU0NmhUR1ZzRjNWUGhMUisr?=
 =?utf-8?B?cEhVZFZFNmpxSGVnckYrM25BZTFpbFBuVHh1dDU2Q05pNmkxRWtuaWJtS3lm?=
 =?utf-8?B?cXJzdE9yOFpXL25zeHJrUmhTZHQvWWt4V09sUk9XRUNNSW9hRVZOckx5MXdm?=
 =?utf-8?B?Q05PWjNlNi9QNDhRUld3UEQyTVoySnBzZWh2UmZNMXZncE1wOFdGa05OM1Ju?=
 =?utf-8?B?UU80WXpNeEl5aVllNGZDNkgvRG93eVZWYkFtaG14N2xHcHJ1Q0xKL0pZWW5o?=
 =?utf-8?B?ejNGRE1JdlZ1TUV2Zi9NbEF6K2xYdWdaK1N6c0MzTC9BbStzUWdJZVQ0bDJG?=
 =?utf-8?B?Q2RzMEZvR3Y2QmJlTEE2dVJjaExoUkZWcWc3eHIxUlU1Zkg1bTdhdzBseStU?=
 =?utf-8?B?Yi9INjBBSVdRc2QybnF3cjVqcE9tNC95ZUhEMlE3RVRlQ1J4V25YZVlIclBO?=
 =?utf-8?B?YnFQaDZydUxnSkpRZnZ6S2JjZ2JTa2JBSFo0UXVUbWVGd3JieGVOR1NmZ3Ni?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	d9MaA3UDziQAjSpV74VfvBiXqbDZW8SdOq8LdMNK3lHcsJbxUm66s4eglxg1YRCsxhY0B6gbeTUaEbnyYvZYaSjp2XF7UjnD6SaIbNV4jR7eikAdvYHo4E704zqDQLMER7ZAV6XLa27IK65xF0KlKaOfs24u4mwVXpD5H/xnHS/+q2IYopdKkP4uuo4mol0MpI8ievefy6OAGAsoC8McmNQzpQEfYJhSpS/TPNoQiKWo2TVvdtEplPSeKsj3YndN0zQZWyJdodDraNzSNCsT/h2UDm+tkfzc6XOla3m2Q2V9WTqXeO4L60JZ2/uSxz4p465+GSKiYxCJjnPUNdSwiw4S/JeoC24jfDXkk5emF6UXUoOSPxF07wYTIzVlVIu7W3EktufUsZzNHymwD4xteV7xR34Z/fqkcatnzq2kubHS5TRFJ1AepWsXrx7lch4T8+vyttK60qKfe9dKlV3UykaFA0QcwLXkGEqKIzirlf11p+IHhxXdQhj5yc0hTpiu0F6dQGVOvLf8ADNeMdIwHjuW2bfk8QxdkboyJjMNdQX3h9YAugQTezE9kMtJuZj46rvS0j3ekqd6ItZCB6Yc528O/y7/JDIjGZ3w5CqAOQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5a7efe-abc8-4d82-b5d0-08dc9fed30d1
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:00:25.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTBezwRsW+zcx1dPqKhfKxNKZkBOaOrw/xqYBrMHrXexKmBwXPcyHbvok3PaUZRH0/7wnJJKomA1/oadmc4iXIHq1gzsFb5fax4kTHnwBDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090052
X-Proofpoint-GUID: 39aSoIHoyvy68BdxZ2NSiJLHkVTm4dhC
X-Proofpoint-ORIG-GUID: 39aSoIHoyvy68BdxZ2NSiJLHkVTm4dhC



On 7/8/24 18:48, Borislav Petkov wrote:
> On Mon, Jul 08, 2024 at 11:49:24AM -0000, tip-bot2 for Alexandre Chartre wrote:
>>   4c 8b 24 25 e0 ff ff    mov    0xffffffffffffffe0,%r12
> 
> Right, this is missing a "ff" which is the 4th byte of a disp32.
> 
> I.e., ModRM=0, SIB=5 simply means that what follows is a disp32 field:
> 
>   REX:                   0x4c { 4 [w]: 1 [r]: 1 [x]: 0 [b]: 0 }
> Opcode:                 0x8b
> ModRM:                  0x24  [mod:0b][.R:1b,reg:1100b][.B:0b,r/m:100b]
>                          register-indirect mode, offset 0
> SIB:                    0x25 [.B:0b,base:101b][.X:0b,idx:100b][scale: 0]
> 
>   MOV Gv,Ev; MOV reg{16,32,64} reg/mem{16,32,64}
>                 0:       4c 8b 24 25 e0 ff ff    mov 0xffffffffffffffe0,%r12
>                 7:       ff

Ah! Right. I regularly got tricked when the opcode is output on two lines :-(

Sorry.

alex.

